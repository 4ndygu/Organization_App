//
//  ViewController.swift
//  o_toolkit
//
//  Created by Student on 2/18/17.
//  Copyright © 2017 wow. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyDb-WaJ15vnHpPKUN9ggEzJPZELKVmqmC0")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var wrongCredentialLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    /*
 
   Note to self (not related to this code): only orgs can create event, add that to org "events you own"
 */
    
    @IBAction func RegisterOrgButton(_ sender: Any) {
        if (nameTextField.text == "" && passTextField.text == "") {
            logoLabel.text = "sign up";
            
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let SignUpController = storyBoard.instantiateViewController(withIdentifier: "signup") as! SignUpController
            
            SignUpController.dataFromAPI = "Register Organization"
            
            self.present(SignUpController, animated:true, completion:nil)
            
            
        } else {
            
            let email = "org:" + nameTextField.text!;
            let password = passTextField.text!;
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                

                if (user == nil) {
                    
                    self.wrongCredentialLabel.text = "Wrong credentials!";
                    
                    self.nameTextField.text = "";
                    
                    self.passTextField.text = "";
                    
                    return
                }
                
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let DashController = storyBoard.instantiateViewController(withIdentifier: "maindash")
                
                self.present(DashController, animated:true, completion:nil)
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any)
    {
        
        logoLabel.text = "sign up";
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let SignUpController = storyBoard.instantiateViewController(withIdentifier: "signup") as! SignUpController
        
        SignUpController.dataFromAPI = "Register User"
        
        self.present(SignUpController, animated:true, completion:nil)
    }

    @IBAction func loginButton(_ sender: Any) {

            let email = nameTextField.text!;
            let password = passTextField.text!;

            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                
                print(user)
                if (user == nil) {
                    
                   
                    self.wrongCredentialLabel.text = "Wrong Credentials!";
                    return
                }
                
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let DashController = storyBoard.instantiateViewController(withIdentifier: "maindash")
                
                self.present(DashController, animated:true, completion:nil)
            //}
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

