import Foundation

public protocol ApiClient {
    func makePublicApiCall(endpoint: String, callback: @escaping (Data?, URLResponse?, Error?) -> Void)
    func makeAuthorizedApiCall(endpoint: String, callback: @escaping (Data?, URLResponse?, Error?) -> Void)
}
