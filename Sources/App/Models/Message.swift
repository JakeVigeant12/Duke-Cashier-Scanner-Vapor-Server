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

    
    @Field(key: "receiverID")
    var receiverID: String
    
    init() {}
    
    init(id: UUID? = nil, content: String, receiverID: String) {
        self.id = id
        self.content = content
        self.receiverID = receiverID
    }
}
