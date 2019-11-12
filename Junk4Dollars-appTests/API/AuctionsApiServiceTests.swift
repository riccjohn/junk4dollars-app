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

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let expectation = XCTestExpectation(description: "Waiting for API response")
        AuctionsApiService.getAllAuctionsFromAPI {data,_error in
            let auctionOne = Auction(
                identifier: 1,
                title: "Throne of Eldraine Booster Box",
                description: "New: A brand-new, unused, unopened, undamaged item (including handmade items).",
                startingPrice: 8500,
//                endsAt: Date()
                endsAt: dateFormatter.date(from: "2019-11-01T20:35:21.000Z" )!
            )

            let auctionTwo = Auction(
                identifier: 3,
                title: "Oko, Theif of Crowns",
                description: "Brand new. Single card",
                startingPrice: 1000,
    //                endsAt: Date()
                endsAt: dateFormatter.date(from: "2019-11-01T20:35:21.000Z" )!
            )


            let auctionsArray = [auctionOne, auctionTwo]

            XCTAssertEqual( auctionsArray, data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
