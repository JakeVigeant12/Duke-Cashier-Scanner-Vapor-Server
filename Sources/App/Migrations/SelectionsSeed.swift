import Vapor
import Fluent

struct SelectionsSeed: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let jsonFilePath = DirectoryConfiguration.detect().resourcesDirectory
        let jsonDataPath = jsonFilePath + "selection_options.json"

        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonDataPath)) else {
            return database.eventLoop.future(error: JSONErrors.jsonFileNotFound)
        }

        
        let seedData = [
            Selections(jsonData: jsonData)
        ]

        return seedData.create(on: database)
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Selections.schema).delete()
    }
}
