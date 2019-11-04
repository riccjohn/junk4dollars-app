import XCTest
import UIKit
import Junk4Dollars_app


class ViewControllerTests: XCTestCase {
    var controller: ViewController!
    
    func setUpController() {
        controller = ViewController()
        controller.label = UILabel()
        controller.textInput = UITextField()
    }
    
    
    func testLabelResetsDefaultValue() {
        setUpController()
        controller.label.text = "foo"
        
        controller.viewDidLoad()
        
        XCTAssertEqual("", controller.label.text)
    }
    
    func testSayHelloWithNoInput() {
        setUpController()
        controller.tapSayHello()
        
        XCTAssertEqual("Hello!", controller.label.text)
    }
    
    func testSayHelloWithNameInput() {
        setUpController()
        controller.textInput.text = "John"
        
        controller.tapSayHello()
        
        XCTAssertEqual("Hello, John!", controller.label.text)
    }
    
    func testResetButtonClearsInputAndLabel() {
        setUpController()
        controller.textInput.text = "John"
        controller.label.text = "Hello!"

        controller.tapReset()

        XCTAssertEqual("", controller.label.text)
        XCTAssertEqual("", controller.textInput.text)
    }
}
