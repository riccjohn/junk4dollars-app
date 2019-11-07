import XCTest
import Junk4Dollars_app

class AuctionsApiServiceTests: XCTestCase {
    // TODO: had to make Auction struct public - is that ok?
    func testCallbackRuns() {
        let expectation = XCTestExpectation(description: "Waiting for API response")
        AuctionsApiService.getAllAuctionsFromAPI {_data,_error in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testApiReturnsAuctions() {
        let expectation = XCTestExpectation(description: "Waiting for API response")
        AuctionsApiService.getAllAuctionsFromAPI {data,_error in
            print("DATA =>", data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
