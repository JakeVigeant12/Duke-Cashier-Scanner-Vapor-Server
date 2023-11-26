import Vapor
import Fluent

final class Message: Model, Content {
    static let schema = "messages"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "content")
    var content: String
    
    @Timestamp(key: "timestamp", on: .create)
    var timestamp: Date?

    
    @Parent(key: "receiverID")
    var receiver: User
    
    init() {}
    
    init(id: UUID? = nil, content: String, receiverID: User.IDValue) {
        self.id = id
        self.content = content
        self.$receiver.id = receiverID
    }
}
