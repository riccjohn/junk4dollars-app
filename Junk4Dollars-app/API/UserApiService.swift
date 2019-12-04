import Foundation

public class UserApiService {
    let client: ApiClient

    public convenience init() {
        let client = AsyncApiClient()
        self.init(client: client)
    }

    public init(client: ApiClient) {
        self.client = client
    }

    public func getUserByToken(token: String, callback: @escaping((ApiCallResult<User>) -> Void)) {
        let endpoint = "http://ec2-52-24-38-188.us-west-2.compute.amazonaws.com:3000/users/\(token)"
        client.makeApiCall(endpoint: endpoint) {data, _, _ in
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
