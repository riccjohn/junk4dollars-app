import Foundation

public class ApiServices {
    let client: HttpClient

    public convenience init() {
        let client = AsyncHttpClient()
        self.init(client: client)
    }

    public init(client: HttpClient) {
        self.client = client
    }

    public func getAllAuctions(callback: @escaping ((HttpCallResult<[Auction]>) -> Void)) {
        let endpoint = "\(ApiEndpoints.apiEndpoint)/auctions"

        let request = HttpRequest(httpMethod: .get, endpoint: endpoint, authenticated: false)

        client.makeHttpCall(httpRequest: request) {data, _, _ in
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

    public func getAuction(id: Int, callback: @escaping ((HttpCallResult<Auction>) -> Void)) {
        let endpoint = "\(ApiEndpoints.apiEndpoint)/auctions/\(id)"
        let request = HttpRequest(httpMethod: .get, endpoint: endpoint, authenticated: false)

        client.makeHttpCall(httpRequest: request) { data, _, _ in
            if let data = data {
                do {
                    let auction = try JSONDecoder().decode(Auction.self, from: data)
                    callback(.success(data: auction))
                } catch {
                    callback(.error(message: "Invalid JSON"))
                }
            } else {
                callback(.error(message: "No data returned"))
            }
        }
    }

    public func getMyUser(callback: @escaping((HttpCallResult<User>) -> Void)) {
        let endpoint = "\(ApiEndpoints.apiEndpoint)/user/me"
        let request = HttpRequest(httpMethod: .get, endpoint: endpoint, authenticated: true)

        client.makeHttpCall(httpRequest: request) {data, _, _ in
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
