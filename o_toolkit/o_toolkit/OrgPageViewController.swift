//
//  OrgPageViewController.swift
//  o_toolkit
//
//  Created by Student on 2/25/17.
//  Copyright © 2017 wow. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import Firebase
import CoreLocation

class OrgPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var actiontitle: String = "";

    // Data model: These strings will be the data for the table view cells
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapViewHolder: GMSMapView!
    
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    var orgID = "123"
    var orgTitle = "defaultTitle"
    
    
    //this constant determines the radius is 1km = 1000m
    let regionRadius: CLLocationDistance = 1000
    
    //this function centers the map on the location you want
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    @IBAction func donateButtonPushed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let DonateController = storyBoard.instantiateViewController(withIdentifier: "donateView") as UIViewController
        
        self.present(DonateController, animated:true, completion:nil)
    }
    

    @IBAction func followButtonPushed(_ sender: Any) {
        
   
        var ref = FIRDatabase.database().reference()
        
        let userRefId = FIRAuth.auth()?.currentUser?.uid
        
        let eventTitle = titleLabel.text
        
        if(followButton.titleLabel?.text == "Follow")
        {
       
            var eventTitle = titleLabel.text
            
            ref.child("users").child(userRefId!).child("following").child(orgID).setValue(["title": eventTitle as! NSString, "time": "getDate" as! NSString])

        
            followButton.setTitle("Unfollow", for: .normal)
        
        }
        else if(followButton.titleLabel?.text == "Unfollow")
        {
            followButton.setTitle("Follow", for: .normal)
            
             let userRefId = FIRAuth.auth()?.currentUser?.uid
            
            ref.child("users").child(userRefId!).child("following").child("orgID").removeValue()
        }
    
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var ref = FIRDatabase.database().reference()

        var gps1 = "";
        var gps2 = "";
        
        // look for everything given ID
        dump(actiontitle)
        ref.child("actions").child(actiontitle).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            dump(value)
            let actualTitle = value?["title"] as! String
            let actualGPS = value?["start"] as! String

            self.titleLabel.text = actualTitle

            let gpsStartArr = actualGPS.components(separatedBy: " ")
            
            let centerGPS = CLLocationDegrees(Int(gpsStartArr[0])!);
            let centerGPS2 = CLLocationDegrees(Int(gpsStartArr[1])!);

            let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 4)
            let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
            
            let position = CLLocationCoordinate2D(latitude: centerGPS, longitude: centerGPS2)
            let marker = GMSMarker(position: position)
            marker.title = "Start"
            marker.map = mapView

            self.mapViewHolder = mapView
            
            
            self.tableView.reloadData()

        })
        
        
        

        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        
        print("here")
    
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        
        let address = "1 Infinite Loop, CA, USA"
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                print(initialLocation)
                self.centerMapOnLocation(location: initialLocation)            }
        })
       
        
        
    
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
