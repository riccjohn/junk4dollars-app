import Foundation

public protocol HttpClient {
    func makeHttpCall(httpRequest: HttpRequest, callback: @escaping(Data?, URLResponse?, Error?) -> Void)
}
