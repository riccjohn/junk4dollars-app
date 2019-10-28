//
//  Junk4Dollars_appUITests.swift
//  Junk4Dollars-appUITests
//
//  Created by John Riccardi on 10/28/19.
//  Copyright © 2019 John Riccardi. All rights reserved.
//

import XCTest

class Junk4Dollars_appUITests: XCTestCase {
    func testHelloDefault() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Say hello"].tap()
        let helloLabel = app.staticTexts["Hello!"]
        XCTAssert(helloLabel.exists)
    }
    
    func testHelloName() {
        let app = XCUIApplication()
        app.launch()
        let textInput = app.textFields["Name"]
        textInput.tap()
        textInput.typeText("John")
        app.buttons["Say hello"].tap()
        let helloJohnLabel = app.staticTexts["Hello, John!"]
        XCTAssert(helloJohnLabel.exists)
    }
    
    func testResetButton() {
        let app = XCUIApplication()
        app.launch()
        let textInput = app.textFields["Name"]
        textInput.tap()
        textInput.typeText("John")
        app.buttons["Say hello"].tap()
        app.buttons["Reset"].tap()
        app.buttons["Say hello"].tap()
        XCTAssert(app.staticTexts["Hello!"].exists)
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
