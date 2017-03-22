//
//  ViewController.swift
//  o_toolkit
//
//  Created by Student on 2/18/17.
//  Copyright © 2017 wow. All rights reserved.
//

import UIKit
import Firebase
class SignUpController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("gothere")
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
        
        let email = mailTextField.text!;
        let password = passTextField.text!;
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, err) in
            
            if err != nil {
                
                print(err)
                
            } else {
                
                FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                    
                    var ref = FIRDatabase.database().reference()
                    
                    //update user on creation into users table
                    ref = ref.child("users")
                    let newUser = user?.uid;
                    let newUserRef = ref.child(newUser!) //lowercase should be UID
                    newUserRef.setValue(newUser)
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    
                    let DashController = storyBoard.instantiateViewController(withIdentifier: "maindash")
                    
                    self.present(DashController, animated:true, completion:nil)
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

