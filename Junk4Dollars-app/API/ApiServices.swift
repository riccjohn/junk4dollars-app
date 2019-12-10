import Foundation

public class ApiServices {
    let client: ApiClient

    public convenience init() {
        let client = AsyncApiClient()
        self.init(client: client)
    }

    public init(client: ApiClient) {
        self.client = client
    }

    public func getAllAuctions(callback: @escaping ((ApiCallResult<[Auction]>) -> Void)) {
        let endpoint = "\(ApiEndpoints.apiEndpoint)/auctions"
        client.makeApiCall(endpoint: endpoint, authenticated: false, data: nil) {data, _, _ in
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

    public func getMyUser(callback: @escaping((ApiCallResult<User>) -> Void)) {
        let endpoint = "\(ApiEndpoints.apiEndpoint)/user/me"
        client.makeApiCall(endpoint: endpoint, authenticated: true, data: nil) {data, _, _ in
            if let data = data {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    callback(.success(data: user))
                } catch {
                    callback(.error(message: "Invalid JSON"))
                }
            } else {
                callback(.error(message: "No data returned"))
            }
        }
    }
}
