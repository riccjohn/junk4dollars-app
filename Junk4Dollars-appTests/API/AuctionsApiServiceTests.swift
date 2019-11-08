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
            let auctionsArray = [Auction(
                                         title: "Throne of Eldraine Booster Box",
                                         description: "New: A brand-new, unused, unopened, undamaged item (including handmade items).",
                                         startingPrice: 8500,
                                         endsAt: Date()
                )]
            XCTAssertEqual( auctionsArray[0], data[0])
            XCTAssertEqual(Auction(title: "Throne of Eldraine Booster Box", description: "New: A brand-new, unused, unopened, undamaged item (including handmade items).", startingPrice: 8500, endsAt: Date()), Auction(title: "Throne of Eldraine Booster Box", description: "New: A brand-new, unused, unopened, undamaged item (including handmade items).", startingPrice: 8500, endsAt: Date()))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
