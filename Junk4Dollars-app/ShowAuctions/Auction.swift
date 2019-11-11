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

    static func from(json: Any) -> Auction {

        // TODO: Probably shouldn't use ANY here and guard against its type
        print("incoming json", json)

        // #### TODO: PICK UP HERE ####
//        if let title = json[0]["title"] as? String {
//            print(title)
//        }

//        return Auction(identifier: json.id, title: json.title, description: json.description, startingPrice: json.starting_price, endsAt: json.ends_at)

    return Auction(
        identifier: 1,
        title: "Throne of Eldraine Booster Box",
        description: "New: A brand-new, unused, unopened, undamaged item (including handmade items).",
        startingPrice: 8500, endsAt: Date())
    }

}

extension Auction: Equatable {
    public static func == (lhs: Auction, rhs: Auction) -> Bool {
        return
            lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.startingPrice == rhs.startingPrice
    }
}
