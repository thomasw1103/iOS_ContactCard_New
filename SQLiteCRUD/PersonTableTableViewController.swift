//
//  PersonTableTableViewController.swift
//  SQLiteCRUD
//
//  Created by Diederich Kroeske on 06/10/2016.
//  Copyright © 2016 Diederich Kroeske. All rights reserved.
//

import UIKit

class PersonTableTableViewController: UITableViewController {
    var persons : [Person] = []
    @IBAction func refresh(_ sender: UIRefreshControl) {
        
        // Connect to db
        JSONHelper.sharedInstance.fetchContacts()
        
        persons = DataBaseHelper.sharedInstance.read()
        
        // Reload the tableview
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
        // End the refresh
        sender.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//beleg?

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataBaseHelper.sharedInstance.read().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)

        // Configure the cell...
        persons = DataBaseHelper.sharedInstance.read()
        cell.textLabel?.text = persons[indexPath.row].firstName! + " " + persons[indexPath.row].lastName!;

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let destination = segue.destinationViewController as! PersonDetailViewController
        //        destination.personFirst.text = "hallo"
        
        // Check if the right segue is handled
        if segue.identifier == "detailSegue" {
            
            // Get destination controller
            if let destination = segue.destination as? DetailViewController {
                
                // Get selected row and lookup selected person in array
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    
                    // Pass person to detailed view
                    let person = persons[(indexPath as NSIndexPath).row]
                    destination.person = person
                    
                }
            }
        }
    }
}
