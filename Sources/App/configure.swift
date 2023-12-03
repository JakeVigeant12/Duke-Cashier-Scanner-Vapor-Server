import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    if let databaseURL = Environment.get("DATABASE_URL") {
        var tlsConfig: TLSConfiguration = .makeClientConfiguration()
        tlsConfig.certificateVerification = .none
        let nioSSLContext = try NIOSSLContext(configuration: tlsConfig)

        var postgresConfig = try SQLPostgresConfiguration(url: databaseURL)
        postgresConfig.coreConfiguration.tls = .require(nioSSLContext)

        app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    }
    
//    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
//        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
//        username: Environment.get("DATABASE_USERNAME") ?? "postgres",
//        password: Environment.get("DATABASE_PASSWORD") ?? "",
//        database: Environment.get("DATABASE_NAME") ?? "edeposit_bag",
//        tls: .prefer(try .init(configuration: .clientDefault)))
//    ), as: .psql)


    app.views.use(.leaf)

    app.migrations.add(CreateSelections())
    app.migrations.add(SelectionsSeed())
    app.migrations.add(CreateUsers())
    app.migrations.add(CreateMessages())


    // register routes
    try routes(app)
}

