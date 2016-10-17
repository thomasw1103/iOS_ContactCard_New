//
//  DetailViewController.swift
//  SQLiteCRUD
//
//  Created by Frank Molengraaf on 16/10/2016.
//  Copyright © 2016 Diederich Kroeske. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var person : Person?
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameLabel.text = person?.firstName
        lastNameLabel.text = person?.lastName
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
