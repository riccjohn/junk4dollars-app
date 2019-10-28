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
    
    func testHelloDefault() {
        app.buttons["hello_btn"].tap()
        let helloLabel = app.staticTexts["output_label"]
        XCTAssert(helloLabel.exists)
    }
    
    func testHelloName() {

        let textInput = app.textFields["text_input"]
        textInput.tap()
        textInput.typeText("John")
        app.buttons["hello_btn"].tap()
        let helloJohnLabel = app.staticTexts["Hello, John!"]
        XCTAssert(helloJohnLabel.exists)
    }
    
    func testResetButton() {
        let textInput = app.textFields["text_input"]
        textInput.tap()
        textInput.typeText("John")
        app.buttons["hello_btn"].tap()
        app.buttons["reset_btn"].tap()
        app.buttons["hello_btn"].tap()
        XCTAssert(app.staticTexts["Hello!"].exists)
    }

    func testLaunchPerformance() {
        if #available(iOS 13.1, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
