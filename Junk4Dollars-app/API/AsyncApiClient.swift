import Foundation

public class AsyncApiClient: ApiClient {
    public func makeApiCall(endpoint: String, authorized: Bool = false, whatToDoWithResponseData: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if(authorized) {
            AuthenticationDependencies.authentication.getAccessToken() { accessToken in
                let task = self.createURLSessionDataTask(endpoint: endpoint, accessToken: accessToken, callback: whatToDoWithResponseData)

                task.resume()
            }
        } else {
            let task = createURLSessionDataTask(endpoint: endpoint, accessToken: nil, callback: whatToDoWithResponseData)
            task.resume()
        }
    }

    private

    func createURLSessionDataTask(endpoint: String, accessToken: String?, callback: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let url = URL(string: endpoint)!
        var request: URLRequest = URLRequest(url: url)

        if let accessToken = accessToken {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        // TODO: inject URLSession.shared for testing
        let dataTask: URLSessionDataTask = URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                print("ERROR: \(error)")
            }
            callback(data, response, error)
        }

        return dataTask
    }
}
