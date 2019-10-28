//
//  ViewController.swift
//  Junk4Dollars-app
//
//  Created by John Riccardi on 10/23/19.
//  Copyright © 2019 John Riccardi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var textInput: UITextField!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label.text = ""
    }

    @IBAction func tapSayHello(_ sender: UIButton) {
        if let text = textInput.text {
            if (text.count > 0) {
                label.text = "Hello, \(text)!"
            } else {
                label.text = "Hello!"
            }
        }
    }
    
    @IBAction func tapReset(_ sender: UIButton) {
        textInput.text = ""
        label.text = ""
    }
    
}

