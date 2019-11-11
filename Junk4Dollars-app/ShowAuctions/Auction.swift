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

    static func from(json: Dictionary<String, Any>) -> Auction {
        // #### TODO: PICK UP HERE ####

        if let identifier = json["id"] as? Int {
            print("ID =>", identifier)
        }

        if let title = json["title"] as? String {
            print("Title =>", title)
        }

        if let description = json["description"] as? String {
            print("Desc =>", description)
        }

        if let startingPrice = json["starting_price"] as? Int {
            print("Start price =>", startingPrice)
        }

        // TODO: This  should be a Date!
        if let endsAt = json["ends_at"] as? String {
            print("Ends at =>", endsAt)
        }

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
