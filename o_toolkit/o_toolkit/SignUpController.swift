//
//  ViewController.swift
//  o_toolkit
//
//  Created by Student on 2/18/17.
//  Copyright © 2017 wow. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
        
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func submitButton(_ sender: Any) {
        
        let x = String(describing: mailTextField.text);
        
        if (x.utf16.count <= 12) {
            // nah
        }
        
        mailTextField.text = "hi";
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

