import Foundation

public class AsyncApiClient: ApiClient {

    public let authentication = AuthenticationDependencies.authentication

    public func makeApiCall(endpoint: String, authenticated: Bool, data: Data?, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let data = data {
//            self.authentication.getAccessToken() { accessToken in
//                let task = self.createURLSessionUploadTask(endpoint: endpoint, data: data, accessToken: accessToken, callback: callback)
//                task.resume()
//            }
        } else {
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

//    func createURLSessionUploadTask(endpoint: String, data: Data, accessToken: String?, callback: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        let url = URL(string: endpoint)!
//        var request: URLRequest = URLRequest(url: url)
//
//        if let accessToken = accessToken {
//            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        }
//
//        let uploadTask: URLSessionUploadTask = URLSession.shared.uploadTask(with: request, from: data, completionHandler: callback)
//        return uploadTask
//    }
}
