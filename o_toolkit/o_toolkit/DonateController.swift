//
//  DonateController.swift
//  o_toolkit
//
//  Created by Student on 3/21/17.
//  Copyright © 2017 wow. All rights reserved.
//

import UIKit

class DonateController: UIViewController {

    @IBOutlet weak var donateSlider: UISlider!
    @IBOutlet weak var donateMoney: UILabel!
    
    var currentValue = 5;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func donateSliderChanged(_ sender: UISlider) {
        currentValue = Int(sender.value)
        donateMoney.text = "Amount: " + String(currentValue)
        print(currentValue);
    }
    
    @IBAction func payButton(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
