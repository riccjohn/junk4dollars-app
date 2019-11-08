import Foundation

public struct Auction {
    public init(title: String, description: String, startingPrice: Int, endsAt: Date) {
        self.title = title
        self.description = description
        self.startingPrice = startingPrice
        self.endsAt = endsAt
    }

    public var title: String
    public var description: String
    public var startingPrice: Int
    public var endsAt: Date

}

extension Auction: Equatable {
    public static func == (lhs: Auction, rhs: Auction) -> Bool {
        return
            lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.startingPrice == rhs.startingPrice
//            lhs.endsAt == rhs.endsAt
    }
}
