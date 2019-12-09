import Foundation

public class AsyncApiClient: ApiClient {
    public func makePublicApiCall(endpoint: String, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = self.createURLSessionDataTask(endpoint: endpoint, accessToken: nil, callback: callback)
        task.resume()
    }

    public func makeAuthorizedApiCall(endpoint: String, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        AuthenticationDependencies.authentication.getAccessToken() { accessToken in
            let task = self.createURLSessionDataTask(endpoint: endpoint, accessToken: accessToken, callback: callback)
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
