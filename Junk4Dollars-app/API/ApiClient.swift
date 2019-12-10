import Foundation

public protocol ApiClient {
    func makeApiCall(endpoint: String, authenticated: Bool, data: Data?, callback: @escaping(Data?, URLResponse?, Error?) -> Void)
}
