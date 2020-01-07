import Foundation

public class AsyncHttpClient: HttpClient {
    public let authentication = AuthenticationDependencies.authentication

    public func makeHttpCall(httpRequest: HttpRequest, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let method = httpRequest.httpMethod
        let endpoint = httpRequest.endpoint
        let authenticated = httpRequest.authenticated
        let uploadData = httpRequest.uploadData

        switch method {
            case .get:
                if(authenticated) {
                    self.authentication.getAccessToken() { accessToken in
                        let task = self.createURLSessionDataTask(endpoint: endpoint, accessToken: accessToken, callback: callback)
                        task.resume()
                    }
                } else {
                    let task = self.createURLSessionDataTask(endpoint: endpoint, accessToken: nil, callback: callback)
                    task.resume()
                }
            case .post:
                self.authentication.getAccessToken() { accessToken in
                    guard let data = uploadData else {
                        return
                    }

                    let task = self.createURLSessionUploadtask(endpoint: endpoint, accessToken: accessToken, data: data, callback: callback)
                    task.resume()
            }
        }
    }

    private

    func createURLSessionUploadtask(endpoint: String, accessToken: String, data: Data, callback: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
        let url = URL(string: endpoint)!
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let uploadTask: URLSessionUploadTask = URLSession.shared.uploadTask(with: request, from: data) {data, response, error in
            if let error = error {
                print("ERROR: \(error)")
            }
            callback(data, response, error)
        }
        return uploadTask
    }

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
