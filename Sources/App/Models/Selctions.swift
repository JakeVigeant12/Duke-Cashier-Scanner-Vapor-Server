import Vapor
import Fluent

final class Selections: Model, Content {
    static let schema = "selections"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "json_data")
    var jsonData: Data

    init() {}

    init(id: UUID? = nil, jsonData: Data) {
        self.id = id
        self.jsonData = jsonData
    }
}

struct SelectionsFormat: Codable {
    let departments: [String]
    let locations: [String: [String]]
    let POSNames: [String: [String]]
}
