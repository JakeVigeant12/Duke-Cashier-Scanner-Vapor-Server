import Vapor
import Fluent

// format of posted JSON
struct CreateMessageInput: Content {
    var content: String
    var senderID: UUID
    var receiverID: UUID
}

// add message to database
func createMessageHandler(req: Request) throws -> EventLoopFuture<Message> {
    let input = try req.content.decode(CreateMessageInput.self)

    // make Vapor object from JSON
    let message = Message(content: input.content, receiverID: input.receiverID)

    // save the message to the DB
    return message.save(on: req.db).map { message }
}
