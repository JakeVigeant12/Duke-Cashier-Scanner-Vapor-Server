import Vapor
import Fluent

struct CreateMessages: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("messages")
            .id()
            .field("content", .string, .required)
            .field("senderID", .uuid, .references("users", "id"))
            .field("receiverID", .uuid, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("messages").delete()
    }
}
