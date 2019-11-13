import Foundation

public class AuctionsApiService {
    static func multipleAuctionsAdapter(json: Array<Dictionary<String, Any>>) -> [Auction] {
        json.map(Auction.from)
    }

    static func singleAuctionAdapter(json: Dictionary<String, Any>) -> Auction {
        Auction.from(json: json)
    }

    public static func getAllAuctions() -> [Auction] {
        let auctions: [Auction] = [
            Auction(identifier: 1, title: "Throne of Eldraine Booster Box", description: "New: A brand-new, unused, unopened, undamaged item (including handmade items).", startingPrice: 8500, endsAt: Date()),
            Auction(identifier: 2, title: "Oko, Theif of Crowns", description: "Brand new. Single card", startingPrice: 1000, endsAt: Date()),
            Auction(identifier: 3, title: "MTG M20 Booster Box", description: "Magic the Gathering MTG Core Set 2020 Booster Box", startingPrice: 9000, endsAt: Date())
        ]

        return auctions
    }
    
    public static func getSingleAuctionFromAPI(id: Int, callback: @escaping (Auction?, Error?) -> Void) -> Void {
        let endpoint = "http://localhost:3000/auctions/\(id)"
        QueryAPI.makeApiCall(endpoint: endpoint) {data, response, error in
            // relies on data
            let jsonData = JSONParsing.decodeAPIResponse(encodedJson: data) as! Dictionary<String, Any>
            let adaptedAuction = singleAuctionAdapter(json: jsonData)

            // relies on callback, adaptedAuctions, error
            callback(adaptedAuction, error)
        }

    }

    public static func getAllAuctionsFromAPI(callback: @escaping ([Auction]?, Error?) -> Void) -> Void {
        let endpoint = "http://localhost:3000/auctions"
        QueryAPI.makeApiCall(endpoint: endpoint) {data, response, error in
            // relies on data
            let jsonData = JSONParsing.decodeAPIResponse(encodedJson: data) as! Array<Dictionary<String, Any>>
            let adaptedAuctions = multipleAuctionsAdapter(json: jsonData)

            // relies on callback, adaptedAuctions, error
            callback(adaptedAuctions, error)
        }
    }
}
