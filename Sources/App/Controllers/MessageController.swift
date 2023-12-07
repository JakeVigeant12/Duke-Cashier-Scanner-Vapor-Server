// Created by Jake Vigeant

import Vapor
import Fluent

// format of posted JSON
struct CreateFormData: Content {
    var userID: String
    var message: String
}

// add message to database
func createMessageHandler(req: Request) throws -> EventLoopFuture<Message> {
    let formData = try req.content.decode(CreateFormData.self)
    // make Vapor object from JSON
    let message = Message(content: formData.message, receiverID: formData.userID)
    // save the message to the DB
    return message.save(on: req.db).map { message }
}
