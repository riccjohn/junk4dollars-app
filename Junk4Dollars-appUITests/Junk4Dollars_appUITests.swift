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

// Can't test this until I can control what the mock api data is 

//    func testTableCellsExist() {
//        let tablesQuery = XCUIApplication().tables
//        XCTAssertTrue(tablesQuery.staticTexts["Throne of Eldraine Booster Box"].exists)
//        XCTAssertTrue(tablesQuery.staticTexts["Oko, Theif of Crowns"].exists)
//        XCTAssertTrue(tablesQuery.staticTexts["MTG M20 Booster Box"].exists)
//    }
}
