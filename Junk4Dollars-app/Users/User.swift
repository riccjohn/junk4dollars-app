public struct User: Codable {
    public let identifier: Int
    public let name: String
    public let email: String

    public init(identifier: Int, name: String, email: String) {
        self.identifier = identifier
        self.name = name
        self.email = email
    }

    enum CodingKeys: String, CodingKey {
        case name
        case email
        case identifier = "id"
    }
}
