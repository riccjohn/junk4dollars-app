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
    
    func testSayHello() {
        print('TESTING SAY HELLO')
    }
}
