import Foundation

public protocol ApiClient {
    func makeApiCall(endpoint: String, whatToDoWithResponseData: @escaping (Data?, URLResponse?, Error?) -> Void)
}
