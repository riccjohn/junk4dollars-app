import XCTest
import Junk4Dollars_app

class AuctionsApiServiceTests: XCTestCase {
    func testCallbackDealsWithReceivingNoData() {
        let expectation = XCTestExpectation(description: "Waiting for API response")
        let client = MockQueryAPI()
        AuctionsApiService(client: client).getAllAuctions {_data, error in
            expectation.fulfill()
            XCTAssertEqual(ApiQueryError.ErrorKind.noData,(error as! ApiQueryError).kind)
        }
        wait(for: [expectation], timeout: 4.0)
    }

    func testCallbackRuns() {
        let expectation = XCTestExpectation(description: "Waiting for API response")
        let client = MockQueryAPI()
        AuctionsApiService(client: client).getAllAuctions {_data,_error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4.0)
    }
}
