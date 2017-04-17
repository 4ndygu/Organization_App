//
//  AddEventViewController.swift
//  o_toolkit
//
//  Created by Student on 3/2/17.
//  Copyright © 2017 wow. All rights reserved.
//

import UIKit
import Firebase

class AddEventViewController: UIViewController {

    @IBOutlet weak var titleBox: UITextField!
    @IBOutlet weak var StartBox: UITextField!
    @IBOutlet weak var timeBox: UITextField!
    @IBOutlet weak var endBox: UITextField!
    @IBOutlet weak var descBox: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddEvent(_ sender: Any) {
        var title = titleBox.text
        var start = StartBox.text
        var time = timeBox.text
        var end = endBox.text
        var desc = descBox.text
        
        var ref = FIRDatabase.database().reference()
        
        let key = ref.child("actions").childByAutoId().key
        let post = ["title": title,
                      "start": start,
                      "time": time,
                      "end": end,
                      "desc": desc];
        let childUpdates = ["/actions/\(key)": post]
        ref.updateChildValues(childUpdates)

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "tooltable") as! ToolTableViewController
        
        self.present(resultViewController, animated:true, completion:nil)

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
