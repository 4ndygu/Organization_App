//
//  ToolTableViewController.swift
//  o_toolkit
//
//  Created by Student on 2/18/17.
//  Copyright © 2017 wow. All rights reserved.
//

import UIKit
import Firebase

class ToolTableViewController: UITableViewController {

    var ref: FIRDatabaseReference!
    
    var oddNumbers = Dictionary<String,String>()
    
    var oddNumbersIndexed = [String]()
    var oddNumbersFollowedIndex = [String]()
    let section = ["events you followed", "events near you"]
    
    // zero is followed, one is all
    var StorageForTwoLists = Array<Array<String>>()
    
    
    func loadOddNumbers()  {
        ref = FIRDatabase.database().reference().child("actions")
//        let userRefId = FIRAuth.auth()?.currentUser?.uid
//
//        ref = ref.child("users").child(userRefId!).child("following")
//        
//        ref.observeSingleEvent(of: .value, with: {
//            snapshot in
//            for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
//                //let title = rest.value!["title"] as? String
//                let title = rest.childSnapshot(forPath: "title").value as? String
//                let key = rest.key as? String
//                self.oddNumbers[title!] = key!
//                self.oddNumbersIndexed.append(title!);
//            }
//            
//            DispatchQueue.main.async{
//                self.tableView.reloadData()
//            }
//        })
        
        var totalArray = Array<String>()
        var followArray = Array<String>()
        StorageForTwoLists.append(followArray)
        StorageForTwoLists.append(totalArray)
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if snapshot.childrenCount > 0 {
                
                for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    guard (rest.value as? [String: AnyObject]) != nil else {
                        continue
                    }
                    let title = rest.childSnapshot(forPath: "title").value as? String
               
                    let key = rest.key as? String
                    self.oddNumbers[title!] = key!
                    self.oddNumbersIndexed.append(title!);
                    self.StorageForTwoLists[1].append(title!);
                    self.StorageForTwoLists[0].append(title!);
                }
                self.tableView.reloadData()
            }
        })

        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        loadOddNumbers();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return section.count;
    }
    
    func tableView( tableView : UITableView,  titleForHeaderInSection section: Int)->String {
        return self.section[section];
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.StorageForTwoLists[section].count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "protocell", for: indexPath)
        
        // Configure the cell...
        //let item = oddNumbers[indexPath.row]
        
        cell.textLabel?.text = self.StorageForTwoLists[indexPath.section][indexPath.row];
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = indexPath.row
        //CODE TO BE RUN ON CELL TOUCH
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let DashController = storyBoard.instantiateViewController(withIdentifier: "orgpage") as! UINavigationController
        let childViewController = DashController.topViewController as! OrgPageViewController
        
        childViewController.actiontitle = oddNumbers[oddNumbersIndexed[indexPath.row]]!
        self.present(DashController, animated:true, completion:nil)
    }

    @IBAction func addEvent(segue:UIStoryboardSegue) {
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
           }
    
    
    

}
