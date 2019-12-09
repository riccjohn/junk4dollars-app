import Foundation

public class AsyncApiClient: ApiClient {
    public func makeApiCall(endpoint: String, authorized: Bool = false, whatToDoWithResponseData: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string: endpoint)!
        var request: URLRequest = URLRequest(url: url)

        if(authorized) {
            AuthenticationDependencies.authentication.getAccessToken() { accessToken in
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
        } else {
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
