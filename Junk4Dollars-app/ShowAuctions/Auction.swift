import Foundation

public struct Auction {
    public init(identifier: Int, title: String, description: String, startingPrice: Int, endsAt: Date) {
        self.identifier = identifier
        self.title = title
        self.description = description
        self.startingPrice = startingPrice
        self.endsAt = endsAt
    }

    public var identifier: Int
    public var title: String
    public var description: String
    public var startingPrice: Int
    public var endsAt: Date

    public static func from(json: Dictionary<String, Any>) -> Auction {
        let identifier = json["id"] as! Int
        let title = json["title"] as! String
        let description = json["description"] as! String
        let startingPrice = json["starting_price"] as! Int
        let stringEndsAt = json["ends_at"] as! String
        let endsAt = JSONParsing.createTimeObject(stringTime: stringEndsAt)

        return Auction(
            identifier: identifier,
            title: title,
            description: description,
            startingPrice: startingPrice,
            endsAt: endsAt
        )
    }

}

extension Auction: Equatable {
    public static func == (lhs: Auction, rhs: Auction) -> Bool {
        return
            lhs.identifier == rhs.identifier
    }
}
