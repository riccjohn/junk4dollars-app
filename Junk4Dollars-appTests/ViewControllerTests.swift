import XCTest
import UIKit
import Junk4Dollars_app


class ViewControllerTests: XCTestCase {
    func testLabelDefaultValue() {
        let controller = ViewController()
        // Need to manually instantiate a new label here using UIKit
        controller.label = UILabel()
        controller.label.text = "foo"
        
        controller.viewDidLoad()
        
        XCTAssertEqual("", controller.label.text)
    }
    
    func testSayHelloDefault() {
        let controller = ViewController()
        controller.label = UILabel()
        controller.textInput = UITextField()
        
        controller.tapSayHello()
        
        XCTAssertEqual("Hello!", controller.label.text)
    }
    
    func testSayHelloWithName() {
        let controller = ViewController()
        controller.label = UILabel()
        controller.textInput = UITextField()
        controller.textInput.text = "John"
        
        controller.tapSayHello()
        
        XCTAssertEqual("Hello, John!", controller.label.text)
    }
    
    func testResetButton() {
        let controller = ViewController()
        controller.label = UILabel()
        controller.textInput = UITextField()
        controller.textInput.text = "John"
        controller.label.text = "Hello!"

        controller.tapReset()

        XCTAssertEqual("", controller.label.text)
        XCTAssertEqual("", controller.textInput.text)
    }
}
