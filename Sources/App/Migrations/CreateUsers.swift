import Fluent
import Vapor

struct CreateUsers: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("netID", .string)
            .create()
    }
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("users").delete()
    }
    
    
    
    
}
