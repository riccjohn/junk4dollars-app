import Foundation

public class AuctionsApiService {
    let client: ApiClient

    public convenience init() {
        let client = AsyncApiClient()
        self.init(client: client)
    }

    public init(client: ApiClient) {
        self.client = client
    }

    public func getAllAuctions(callback: @escaping ((ApiCallResult<[Auction]>) -> Void)) {
        let endpoint = "http://ec2-52-24-38-188.us-west-2.compute.amazonaws.com:3000/auctions"
        client.makeApiCall(endpoint: endpoint, authorized: false) {data, _, _ in
            if let data = data {
                do {
                    let auctions = try JSONDecoder().decode([Auction].self, from: data)
                    callback(.success(data: auctions))
                } catch {
                    callback(.error(message: "Invalid JSON"))
                }
            } else {
                callback(.error(message: "No data returned"))
            }
        }
    }

}
