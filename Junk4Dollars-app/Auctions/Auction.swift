import Foundation

public struct Auction: Codable {

    public let identifier: Int
    public let title: String
    public let description: String
    public let startingPrice: Int
    public let endsAtString: String
    public var endsAt: Date? {
        return Time.parseDateFrom(string: endsAtString)
    }


    public init(identifier: Int, title: String, description: String, startingPrice: Int, endsAt: String) {
        self.identifier = identifier
        self.title = title
        self.description = description
        self.startingPrice = startingPrice
        self.endsAtString = endsAt
    }

    enum CodingKeys: String, CodingKey {
        case title
        case identifier = "id"
        case description
        case startingPrice = "starting_price"
        case endsAtString = "ends_at"
    }
}

extension Auction: Equatable {
    public static func == (lhs: Auction, rhs: Auction) -> Bool {
        return
            lhs.identifier == rhs.identifier
    }
}
