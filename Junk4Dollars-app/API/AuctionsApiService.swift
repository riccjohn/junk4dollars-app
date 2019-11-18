import Foundation

public class AuctionsApiService {
    let client: ApiCallable

    public convenience init() {
        let client = ApiClient()
        self.init(client: client)
    }

    public init(client: ApiCallable) {
        self.client = client
    }

    static func multipleAuctionsAdapter(json: Array<Dictionary<String, Any>>) -> [Auction] {
        json.map(Auction.from)
    }
    
    public func getAllAuctions(callback: @escaping ([Auction]?, Error?) -> Void) -> Void {
        let endpoint = "http://localhost:3000/auctions"
        client.makeApiCall(endpoint: endpoint) {data, response, error in
            // relies on data
            if let data = data {
                if data.isEmpty {
                    // TODO: Base decison on response code
                    return callback(Optional<[Auction]>(nilLiteral: ()), ApiQueryError(kind: .noData))
                } else {
                    let jsonData = JSONParsing.decodeAPIResponse(encodedJson: data) as! Array<Dictionary<String, Any>>

                    let adaptedAuctions = AuctionsApiService.multipleAuctionsAdapter(json: jsonData)
                    return callback(adaptedAuctions, error)
                }
            }
            return callback(Optional<[Auction]>(nilLiteral: ()), ApiQueryError(kind: .noData))
        }
    }
}
