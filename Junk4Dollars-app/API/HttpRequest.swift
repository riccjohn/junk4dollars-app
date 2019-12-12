import Foundation

public class HttpRequest {
    public let httpMethod: HttpMethod
    public let endpoint: String
    public let authenticated: Bool
    public let data: Data?

    public init(httpMethod: HttpMethod, endpoint: String, authenticated: Bool, data: Data?) {
        self.httpMethod = httpMethod
        self.endpoint = endpoint
        self.authenticated = authenticated
        self.data = data
    }
}
