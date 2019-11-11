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

    static func miniAdapter(json: Array<Dictionary<String, Any>>) -> [Auction] {
        // map over the json using the .from method we put on the Auction struct
        json.map(Auction.from)
    }

    public static func getAllAuctionsFromAPI(callback: @escaping ([Auction]?, Error?) -> Void) -> Void {
        let session = URLSession.shared
        let request: URLRequest = URLRequest(url: URL(string: "http://localhost:3000/auctions")!)
        // create new request hitting local rails server (for now), pass in a callback
        let task = session.dataTask(with: request) {data, response, error in

            if let error = error {
                print("ERROR: \(error)")
            }

            guard let data = data else { return }

            var adaptedAuctions: [Auction]

            do {
                if let json = try JSONSerialization.jsonObject(with: data , options: []) as? Array<Dictionary<String, Any>> {
//                    if let title = json[0]["title"] as? String {
//                        print(title)
//                    }
                    adaptedAuctions = miniAdapter(json: json)
                    callback(adaptedAuctions, error)

                }
            } catch let err {
                print(err.localizedDescription)
                callback(nil, NSError(domain: "Could not decode API response", code: -1, userInfo: nil))
            }

//            var adaptedAuctions: [Auction]
//
//            if json is [Any] {
//                // TODO: for below line: y tho? Why do we have to coerce `as! [Any]` if preceeding line already assures that?
//                adaptedAuctions = miniAdapter(json: json as! [Any])
//                print("Auctions =>", adaptedAuctions)
//
//                // call callback using the fake data instead of the data coming back from the URL
//                callback(adaptedAuctions, error)
//            } else {
//                // TODO: figure out how to create an Error object properly
//                print("ERROR IN CALLBACK")
//                callback(nil, NSError(domain: "", code: -1, userInfo: nil))
//            }
        }

        task.resume()

    }
}
