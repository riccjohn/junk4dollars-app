public struct User: Codable {
    public let identifier: Int
    public let name: String

    public init(identifier: Int, name: String) {
        self.identifier = identifier
        self.name = name
    }

    enum CodingKeys: String, CodingKey {
        case name
        case identifier = "id"
    }
}
