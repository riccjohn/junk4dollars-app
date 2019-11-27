import Foundation

public class AsyncApiClient: ApiClient {
    public func makeApiCall(endpoint: String, whatToDoWithResponseData: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string: endpoint)!
        let request: URLRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                print("ERROR: \(error)")
            }
            whatToDoWithResponseData(data, response, error)
        }

        task.resume()
    }
}
