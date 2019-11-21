import Foundation
import Junk4Dollars_app

public class FakeApiClient: ApiClient {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    public init() {
        data = Data()
        response = Optional<URLResponse>(nilLiteral: ())
        error = Optional<Error>(nilLiteral: ())
    }

    public func stub(responseAsJson: [[String:Any]]) {
        data = JsonHelper.asJson(list: responseAsJson).data(using: .utf8)
        response = HTTPURLResponse(url: URL(string: "foo.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])
        error = nil
    }

    public func stub(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    public func makeApiCall(endpoint: String, whatToDoWithResponseData: @escaping (Data?, URLResponse?, Error?) -> Void) -> Void {
        whatToDoWithResponseData(self.data, self.response, self.error)
    }
}
