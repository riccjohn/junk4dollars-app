import Foundation

public protocol ApiClient {
    func makeApiCall(endpoint: String, authorized: Bool, whatToDoWithResponseData: @escaping (Data?, URLResponse?, Error?) -> Void)
}
