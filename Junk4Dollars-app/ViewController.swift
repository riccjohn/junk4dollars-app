import UIKit

public class ViewController: UIViewController {

    
    @IBOutlet var textInput: UITextField!
    @IBOutlet public var label: UILabel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label.text = ""
    }

    @IBAction func tapSayHello() {
        if let text = textInput.text {
            if (text.count > 0) {
                label.text = "Hello, \(text)!"
            } else {
                label.text = "Hello!"
            }
        }
    }
    
    @IBAction func tapReset() {
        textInput.text = ""
        label.text = ""
    }
    
}

