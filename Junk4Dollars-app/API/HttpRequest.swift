import Foundation

public class HttpRequest {
    public let httpMethod: HttpMethod
    public let endpoint: String
    public let authenticated: Bool
    public var uploadData: Data? = nil

    public init(httpMethod: HttpMethod, endpoint: String, authenticated: Bool) {
        self.httpMethod = httpMethod
        self.endpoint = endpoint
        self.authenticated = authenticated
    }

    public init(httpMethod: HttpMethod, endpoint: String, authenticated: Bool, uploadData: Data) {
        self.httpMethod = httpMethod
        self.endpoint = endpoint
        self.authenticated = authenticated
        self.uploadData = uploadData
    }
}
