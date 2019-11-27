public struct User: Codable {
    public let identifier: Int
    public let name: String

    public init(identifier: Int, title: String) {
        self.identifier = identifier
        self.name = title
    }

    enum CodingKeys: String, CodingKey {
        case name
        case identifier = "id"
    }
}
