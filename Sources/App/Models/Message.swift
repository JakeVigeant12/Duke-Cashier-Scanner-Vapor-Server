import Vapor
import Fluent

final class Message: Model, Content {
    static let schema = "messages"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "content")
    var content: String
    
    @Parent(key: "senderID")
    var sender: User
    
    @Parent(key: "receiverID")
    var receiver: User
    
    init() {}
    
    init(id: UUID? = nil, content: String, senderID: User.IDValue, receiverID: User.IDValue) {
        self.id = id
        self.content = content
        self.$sender.id = senderID
        self.$receiver.id = receiverID
    }
}
