//
//  OrgPageViewController.swift
//  o_toolkit
//
//  Created by Student on 2/25/17.
//  Copyright © 2017 wow. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

class OrgPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var actiontitle: String = "";

    // Data model: These strings will be the data for the table view cells
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapViewHolder: GMSMapView!
    
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    @IBAction func donateButtonPushed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let DonateController = storyBoard.instantiateViewController(withIdentifier: "donateView") as UIViewController
        
        self.present(DonateController, animated:true, completion:nil)
    }
    

    @IBAction func followButtonPushed(_ sender: Any) {
        
   
        var ref = FIRDatabase.database().reference()
        
        let userRefId = FIRAuth.auth()?.currentUser?.uid
        
        var eventTitle = titleLabel.text
        
        ref.child("users").child(userRefId!).childByAutoId().setValue(["title": eventTitle as! NSString, "time": "getDate" as! NSString])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 1.285, longitude: 103.848, zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.mapViewHolder = mapView
        
        titleLabel.text = actiontitle
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.animals[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
