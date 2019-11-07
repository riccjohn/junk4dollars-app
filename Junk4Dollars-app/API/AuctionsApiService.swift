import Foundation

class AuctionsApiService {
    public static func getAllAuctions() -> [Auction] {
        let auctions: [Auction] = [
            Auction(title: "Throne of Eldraine Booster Box", description: "New: A brand-new, unused, unopened, undamaged item (including handmade items).", startingPrice: 8500, endsAt: Date()),
            Auction(title: "Oko, Theif of Crowns", description: "Brand new. Single card", startingPrice: 1000, endsAt: Date()),
            Auction(title: "MTG M20 Booster Box", description: "Magic the Gathering MTG Core Set 2020 Booster Box", startingPrice: 9000, endsAt: Date())
        ]

        return auctions
    }
}
