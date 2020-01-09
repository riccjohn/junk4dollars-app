import Junk4Dollars_app
import XCTest

class TimeTests: XCTestCase {

    // will be outdated
    func test_localCanParseServerTime_toLocalFormat() {
        let serverTime: String = "2019-11-18T20:25:58.247Z"
        
        let localTime: String? = Time(utc: serverTime).local()
        XCTAssertEqual("11-18-2019 2:25 PM", localTime)
    }

    // will be outdated
    func test_localReturnsNil_forInvalidDateFormat() {
        let serverTime: String = "2019-11-18T20:25:58Z"
        XCTAssertEqual(nil, Time(utc: serverTime).local())
    }

    func test_parseDateFromString_returnsDate() {
        let serverTime: String = "2019-11-18T20:25:58.247Z"
        let date = Time.parseDateFrom(string: serverTime)
        XCTAssertNotNil(date)
        XCTAssertTrue(date! is Date)
    }

    func test_formatDate_returnsFormattedString() {
        let date = Time.parseDateFrom(string: "2019-11-18T20:25:58.247Z")!
        let dateString = Time.format(date: date)
        XCTAssertEqual("11-18-2019 2:25 PM", dateString)
    }

}
