import Foundation

public class AsyncApiClient: ApiClient {
    public func makeApiCall(endpoint: String, whatToDoWithResponseData: @escaping (Data?, URLResponse?, Error?) -> Void) {
        AuthenticationDependencies.authentication.getAccessToken() { accessToken in
            let url = URL(string: endpoint)!
            var request: URLRequest = URLRequest(url: url)
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            // inject URLSession.shared for testing
            let task = URLSession.shared.dataTask(with: request) {data, response, error in
                if let error = error {
                    print("ERROR: \(error)")
                }
                whatToDoWithResponseData(data, response, error)
            }
            task.resume()
        }
    }
}
