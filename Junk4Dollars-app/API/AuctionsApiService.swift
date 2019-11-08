import Foundation

public class AuctionsApiService {
    public static func getAllAuctions() -> [Auction] {
        let auctions: [Auction] = [
            Auction(identifier: 1, title: "Throne of Eldraine Booster Box", description: "New: A brand-new, unused, unopened, undamaged item (including handmade items).", startingPrice: 8500, endsAt: Date()),
            Auction(identifier: 2, title: "Oko, Theif of Crowns", description: "Brand new. Single card", startingPrice: 1000, endsAt: Date()),
            Auction(identifier: 3, title: "MTG M20 Booster Box", description: "Magic the Gathering MTG Core Set 2020 Booster Box", startingPrice: 9000, endsAt: Date())
        ]

        return auctions
    }

    public static func getAllAuctionsFromAPI(callback: @escaping ([Auction], Error?) -> Void) -> Void {
        let session = URLSession.shared
        // create new request hitting Google (for now), pass in a callback
        let task = session.dataTask(with: URL(string: "https://www.google.com")!) {data, response, error in

            if let error = error {
                print("ERROR: \(error)")
            }

            let auctions = [Auction(identifier: 4, title: "Throne of Eldraine Booster Box", description: "New: A brand-new, unused, unopened, undamaged item (including handmade items).", startingPrice: 8500, endsAt: Date())]

            // call callback using the fake data instead of the data coming back from the URL
            callback(auctions, nil)
        }

        task.resume()

    }
}
