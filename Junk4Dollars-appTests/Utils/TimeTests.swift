import Junk4Dollars_app
import XCTest

class TimeTests: XCTestCase {
    func test_parseDateFromString_returnsDate() {
        let serverTime: String = "2019-11-18T20:25:58.247Z"
        let date = Time.parseDateFrom(string: serverTime)
        XCTAssertNotNil(date)
        XCTAssertTrue(date! is Date)
    }

    func test_formatDate_returnsFormattedString() {
        let date = Time.parseDateFrom(string: "2019-11-01T20:35:21.000Z")!
        let dateString = Time.format(date: date)
        XCTAssertEqual("11-01-2019 3:35 PM", dateString)
    }

}
