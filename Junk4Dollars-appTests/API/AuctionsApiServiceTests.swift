import XCTest
import Junk4Dollars_app

class AuctionsApiServiceTests: XCTestCase {

    func testGetAllAuctions_WhenApiClientReturnsValidJson_TriggersCallbackWithSuccess() {
        let client = FakeApiClient()
        client.stub(responseAsJson: [[
            "id": 555,
            "title": "Throne of Eldraine Booster Box",
            "description": "New",
            "starting_price": 8500,
            "ends_at": "2019-11-01T20:35:21.000Z",
            "created_at": "2019-11-18T20:25:58.247Z",
            "updated_at": "2019-11-18T20:25:58.247Z"
        ]])
        var isSuccess = false
        var actualAuctions: [Auction]?

        AuctionsApiService(client: client).getAllAuctions { apiCallResult in
            switch apiCallResult {
                case .success(let data):
                    isSuccess = true
                    actualAuctions = data
                default:
                    break
            }
        }

        XCTAssertTrue(isSuccess)
        XCTAssertNotNil(actualAuctions)
        XCTAssertEqual(1, actualAuctions?.count)
        XCTAssertEqual(555, actualAuctions?.first?.identifier)
    }

    func testGetAllAuctions_WhenApiClientReturns400WithNoData_TriggersCallbackWithError() {
        let client = FakeApiClient()
        let response = HTTPURLResponse(url: URL(string: "foo.com")!, statusCode: 400, httpVersion: nil, headerFields: [:])
        let error: Error? = nil
        client.stub(data: nil, response: response, error: error)
        var isError = false

        AuctionsApiService(client: client).getAllAuctions { apiCallResult in
            switch apiCallResult {
                case .error:
                    isError = true
                default:
                    break
            }
        }

        XCTAssertTrue(isError)
    }

    func testGetAuctions_WhenApiClientReturns404WithInvalidJson_TriggersCallbackWithError() {
        let client = FakeApiClient()
        let data = "Not found".data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "foo.com")!, statusCode: 404, httpVersion: nil, headerFields: [:])
        let error: Error? = nil
        client.stub(data: data, response: response, error: error)
        var isError = false

        AuctionsApiService(client: client).getAllAuctions { apiCallResult in
            switch apiCallResult {
                case .error:
                    isError = true
                default:
                    break
            }
        }

        XCTAssertTrue(isError)
    }

    func testGetAllAuctions_WhenApiClientReturnsValidJsonMissingField_TriggersCallbackWithError() {
        let client = FakeApiClient()
        client.stub(responseAsJson: [[
            "id": 555
        ]])
        var isError = false

        AuctionsApiService(client: client).getAllAuctions { apiCallResult in
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
