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

    // Used for a group of results (multiple Auctions)
    public func stub(responseAsJson: [[String:Any]]) {
        data = JsonHelper.asJson(list: responseAsJson).data(using: .utf8)
        response = HTTPURLResponse(url: URL(string: "foo.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])
        error = nil
    }

    // Used for a single result (a single Auction)
    public func stub(responseAsJson: [String:Any]) {
        data = JsonHelper.asJson(dictionary: responseAsJson).data(using: .utf8)
        response = HTTPURLResponse(url: URL(string: "foo.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])
        error = nil
    }

    public func stub(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    public func makeApiCall(endpoint: String, authorized: Bool = false, whatToDoWithResponseData: @escaping (Data?, URLResponse?, Error?) -> Void) {
        whatToDoWithResponseData(self.data, self.response, self.error)
    }
}
