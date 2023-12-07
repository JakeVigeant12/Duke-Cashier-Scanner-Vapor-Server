// Created by Jake Vigeant
import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor
import Logging


// configures your application
public func configure(_ app: Application) async throws {
    // logging for deployment info
    let logger = Logger(label: "edeposit-backend")

     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    //MARK: Establish database connection, with local fallback if heroku environment variables cannot be found
    if let databaseURL = Environment.get("DATABASE_URL") {
        print("Found Postgres")
        logger.info("Found Postgres")
        var tlsConfig: TLSConfiguration = .makeClientConfiguration()
        tlsConfig.certificateVerification = .none
        let nioSSLContext = try NIOSSLContext(configuration: tlsConfig)

        var postgresConfig = try SQLPostgresConfiguration(url: databaseURL)
        postgresConfig.coreConfiguration.tls = .require(nioSSLContext)

        app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    }
    else{
            print("Rempote connection failed")
            logger.info("Rempote connection failed")

            app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
                hostname: Environment.get("DATABASE_HOST") ?? "localhost",
                port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
                username: Environment.get("DATABASE_USERNAME") ?? "postgres",
                password: Environment.get("DATABASE_PASSWORD") ?? "",
                database: Environment.get("DATABASE_NAME") ?? "edeposit_bag",
                tls: .prefer(try .init(configuration: .clientDefault)))
            ), as: .psql)
    }

    app.views.use(.leaf)

    app.migrations.add(CreateSelections())
    app.migrations.add(SelectionsSeed())
    app.migrations.add(CreateUsers())
    app.migrations.add(CreateMessages())


    // register routes
    try routes(app)
}

