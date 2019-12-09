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

    public func getMyUser(callback: @escaping((ApiCallResult<User>) -> Void)) {
        let endpoint = "\(ApiEndpoints.apiEndpoint)/user/me"
        client.makeAuthorizedApiCall(endpoint: endpoint) {data, _, _ in
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
