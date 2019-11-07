import XCTest
import Junk4Dollars_app

class AuctionsApiServiceTests: XCTestCase {
    // TODO: had to make Auction struct public - is that ok?
    func testExample() {
        var session =   URLSession.shared
        let expectation = XCTestExpectation(description: "IVE BEEN EXPECTING YOU")

        AuctionsApiService.getAllAuctionsFromAPI {data,response,error in
            guard let data = data else {
                fatalError("NO DATA")
            }

            guard let response = response else {
                fatalError("NO RESPONSE")
            }

            print("Data =>", data)
            print("Response =>", response)
            print("Error =>", error)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
