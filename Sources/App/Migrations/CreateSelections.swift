import Fluent
import Vapor

struct CreateSelections: AsyncMigration {
    func prepare(on database: Database) async throws {        
        try await database.schema("selections")
            .id()
            .field("json_data", .data)
            .create()
    }
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("selections").delete()
    }
    
    
    
    
}
