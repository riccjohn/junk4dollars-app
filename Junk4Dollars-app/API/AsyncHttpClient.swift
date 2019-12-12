import Foundation

public class AsyncHttpClient: HttpClient {
    public let authentication = AuthenticationDependencies.authentication

    public func makeHttpCall(httpRequest: HttpRequest, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let method = httpRequest.httpMethod
        let data = httpRequest.data
        let endpoint = httpRequest.endpoint
        let authenticated = httpRequest.authenticated

        if(authenticated) {
            self.authentication.getAccessToken() { accessToken in
                let task = self.createURLSessionDataTask(endpoint: endpoint, accessToken: accessToken, callback: callback)
                task.resume()
            }
        } else {
            let task = self.createURLSessionDataTask(endpoint: endpoint, accessToken: nil, callback: callback)
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

        let dataTask: URLSessionDataTask = URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                print("ERROR: \(error)")
            }
            callback(data, response, error)
        }

        return dataTask
    }
}
