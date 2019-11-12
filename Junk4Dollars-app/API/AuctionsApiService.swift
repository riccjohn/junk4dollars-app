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

    static func multipleAuctionsAdapter(json: Array<Dictionary<String, Any>>) -> [Auction] {
        json.map(Auction.from)
    }

    public static func getAllAuctionsFromAPI(callback: @escaping ([Auction]?, Error?) -> Void) -> Void {
        let request: URLRequest = URLRequest(url: URL(string: "http://localhost:3000/auctions")!)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in

            if let error = error {
                print("ERROR: \(error)")
            }

            guard let data = data else { return }

            var adaptedAuctions: [Auction]

            let jsonData = JSONParsing.decodeAPIResponse(encodedJson: data) as! Array<Dictionary<String, Any>>
            // Currently blowing up if Auction.from can't create an Auction from incoming parsed json
            adaptedAuctions = multipleAuctionsAdapter(json: jsonData)
            callback(adaptedAuctions, error)
        }

        task.resume()

    }
}
