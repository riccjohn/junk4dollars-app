import XCTest

class Junk4Dollars_appUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testTableCellsExist() {
        let tablesQuery = XCUIApplication().tables
        XCTAssertTrue(tablesQuery.staticTexts["Throne of Eldraine Booster Box"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["Oko, Theif of Crowns"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["MTG M20 Booster Box"].exists)
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
