public struct Auction: Codable {

    public let identifier: Int
    public let title: String

    public init(identifier: Int, title: String) {
        self.identifier = identifier
        self.title = title
    }

    enum CodingKeys: String, CodingKey {
        case title
        case identifier = "id"
    }

}

extension Auction: Equatable {
    public static func == (lhs: Auction, rhs: Auction) -> Bool {
        return
            lhs.identifier == rhs.identifier
    }
}
