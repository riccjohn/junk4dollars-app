import XCTest
import Junk4Dollars_app

class HttpRequestTests: XCTestCase {
    func test_HttpRequest_returnsObject_withHttpMethodEnum() {
        let request = HttpRequest(httpMethod: .get, endpoint: "foo", authenticated: false)
        XCTAssertEqual(.get, request.httpMethod)
    }

    func test_HttpRequest_returnsObject_withEndpoint() {
        let request = HttpRequest(httpMethod: .get, endpoint: "www.foo.com/api/users/", authenticated: false)
        XCTAssertEqual("www.foo.com/api/users/", request.endpoint)
    }

    func test_HttpRequest_reutrnsObject_withauthenticatedBool() {
        let request = HttpRequest(httpMethod: .get, endpoint: "foo", authenticated: false)
        XCTAssertEqual(false, request.authenticated)
    }
}
