public struct Auction: Codable {

    public let identifier: Int
    public let title: String
    public let description: String
    public let starting_price: Int
    public let ends_at: String
    public var bid: Bid? = nil

    public struct Bid: Codable {
        public let price: Int
        public let created_at: String
    }

    public init(identifier: Int, title: String, description: String, starting_price: Int, ends_at: String, bid: Bid?) {
        self.identifier = identifier
        self.title = title
        self.description = description
        self.starting_price = starting_price
        self.ends_at = ends_at
        if let bid = bid {
            self.bid = Bid(price: bid.price, created_at: bid.created_at)
        } else {
            self.bid = nil
        }
    }

    public init(identifier: Int, title: String, description: String, starting_price: Int, ends_at: String) {
        self.identifier = identifier
        self.title = title
        self.description = description
        self.starting_price = starting_price
        self.ends_at = ends_at
    }

    enum CodingKeys: String, CodingKey {
        case title
        case identifier = "id"
        case description
        case starting_price
        case ends_at
        case bid
    }
}

extension Auction: Equatable {
    public static func == (lhs: Auction, rhs: Auction) -> Bool {
        return
            lhs.identifier == rhs.identifier
    }
}
