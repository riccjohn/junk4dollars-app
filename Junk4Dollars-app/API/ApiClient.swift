import Foundation

public protocol ApiClient {
    func getPublicDataFromApi(endpoint: String, callback: @escaping (Data?, URLResponse?, Error?) -> Void)
    func getSecureDataFromApi(endpoint: String, callback: @escaping (Data?, URLResponse?, Error?) -> Void)
}
