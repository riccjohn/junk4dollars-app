import XCTest
import Junk4Dollars_app

class UsersApiServiceTests: XCTestCase {
    func testGetUserByToken_WhenApiClientReturnsValidJson_TriggersCallbackWithSuccess() {
        let client = FakeApiClient()

        let user: [String:Any] = [
            "id": 1,
            "name": "John",
            "email": "john@8thlight.com"
        ]

        client.stub(responseAsJson: user)
        var isSuccess = false
        var actualUser: User?

        UserApiService(client: client).getUserByToken(token: "foo") { apiCallResult in
            switch apiCallResult {
                case .success(let data):
                    isSuccess = true
                    actualUser = data
                default:
                    break
            }
        }

        XCTAssertTrue(isSuccess)
        XCTAssertNotNil(actualUser)
        XCTAssertEqual("John", actualUser?.name)
    }

    func testGetUserByToken_WhenApiClientReturns400WithNoData_TriggersCallbackWithErroro() {
        let client = FakeApiClient()
        let response = HTTPURLResponse(url: URL(string: "foo.com")!, statusCode: 400, httpVersion: nil, headerFields: [:])
        let error: Error? = nil
        client.stub(data: nil, response: response, error: error)
        var isError = false

        UserApiService(client: client).getUserByToken(token: "foo") { apiCallResult in
            switch apiCallResult {
                case .error:
                    isError = true
                default:
                    break
            }
        }

        XCTAssertTrue(isError)
    }

    func testGetUserByToken_WhenAPIClientReturns404WithInvalidJson_TriggersCallbackWithError() {
        let client = FakeApiClient()
        let data = "Not found".data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "foo.com")!, statusCode: 404, httpVersion: nil, headerFields: [:])
        let error: Error? = nil
        client.stub(data: data, response: response, error: error)
        var isError = false

        UserApiService(client: client).getUserByToken(token: "foo") { apiCallResult in
            switch apiCallResult {
                case .error:
                    isError = true
                default:
                    break;
            }
        }

        XCTAssertTrue(isError)
    }

    func testGetUserByToken_WhenApiClientReturnsValidJsonMissingField_TriggersCallbackWithError() {
        let client = FakeApiClient()
        client.stub(responseAsJson: [[
            "id": 555
        ]])
        var isError = false

        UserApiService(client: client).getUserByToken(token: "foo") { apiCallResult in
            switch apiCallResult {
                case .error:
                    isError = true
                default:
                    break
            }
        }

        XCTAssertTrue(isError)
    }
}
