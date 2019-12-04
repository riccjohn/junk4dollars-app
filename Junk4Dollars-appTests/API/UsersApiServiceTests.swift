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
}
