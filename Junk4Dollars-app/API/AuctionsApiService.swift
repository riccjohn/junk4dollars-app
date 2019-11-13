import Foundation

public class AuctionsApiService {
    let client: APICallable

    public convenience init() {
        let client = QueryAPI()
        self.init(client: client)
    }

    public init(client: APICallable) {
        self.client = client
    }

    static func multipleAuctionsAdapter(json: Array<Dictionary<String, Any>>) -> [Auction] {
        json.map(Auction.from)
    }

//    static func singleAuctionAdapter(json: Dictionary<String, Any>) -> Auction {
//        Auction.from(json: json)
//    }
    
//    public func getSingleAuction(id: Int, callback: @escaping (Auction?, Error?) -> Void) -> Void {
//        let endpoint = "http://localhost:3000/auctions/\(id)"
//        client.makeApiCall(endpoint: endpoint) {data, response, error in
//            // relies on data
//            let jsonData = JSONParsing.decodeAPIResponse(encodedJson: data) as! Dictionary<String, Any>
//            let adaptedAuction = AuctionsApiService.singleAuctionAdapter(json: jsonData)
//
//            // relies on callback, adaptedAuctions, error
//            callback(adaptedAuction, error)
//        }
//    }

    public func getAllAuctions(callback: @escaping ([Auction]?, Error?) -> Void) -> Void {
        let endpoint = "http://localhost:3000/auctions"
        client.makeApiCall(endpoint: endpoint) {data, response, error in
            // relies on data
            if let data = data {
                if data.isEmpty {
                    callback(Optional<[Auction]>(nilLiteral: ()), ApiQueryError(kind: .noData))
                } else {
                    let jsonData = JSONParsing.decodeAPIResponse(encodedJson: data) as! Array<Dictionary<String, Any>>

                    let adaptedAuctions = AuctionsApiService.multipleAuctionsAdapter(json: jsonData)
                    callback(adaptedAuctions, error)
                }
            }
            callback(Optional<[Auction]>(nilLiteral: ()), ApiQueryError(kind: .noData))
        }
    }
}
