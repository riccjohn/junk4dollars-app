import Junk4Dollars_app
import XCTest

class PriceTests: XCTestCase {
    func testPriceInDollars_willAddDecimalAndDollarSign() {
        let price = Price(inCents: 100)
        let dollarPrice = price.inDollars()

        XCTAssertEqual("$1.00", dollarPrice)
    }

    func testPriceInDollars_willDealWithLargeNumbers() {
        let price = Price(inCents: 1239876)
        let dollarPrice = price.inDollars()

        XCTAssertEqual("$12,398.76", dollarPrice)
    }
}
