import Vapor
import Fluent

final class User: Model, Content {
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "netID")
    var netID: String

    init() {}

    init(id: UUID? = nil, netID: String) {
        self.id = id
        self.netID = netID
    }
}
