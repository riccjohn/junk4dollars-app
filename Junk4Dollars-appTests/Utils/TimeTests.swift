import Junk4Dollars_app
import XCTest

class TimeTests: XCTestCase {
    func test_localCanParseServerTime_toLocalFormat() {
        let serverTime: String = "2019-11-18T20:25:58.247Z"
        
        let localTime: String? = Time(utc: serverTime).local()
        XCTAssertEqual("11-18-2019 2:25 PM", localTime)
    }

    func test_localReturnsNil_forInvalidDateFormat() {
        let serverTime: String = "2019-11-18T20:25:58Z"
        XCTAssertEqual(nil, Time(utc: serverTime).local())
    }
}
