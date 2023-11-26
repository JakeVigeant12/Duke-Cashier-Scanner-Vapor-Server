import Vapor
import Fluent

struct CreateMessages: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("messages")
            .id()
            .field("content", .string, .required)
            .field("timestamp", .datetime)
            .field("receiverID", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("messages").delete()
    }
}
