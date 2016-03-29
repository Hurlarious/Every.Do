//
//  AllListsViewController.swift
//  Every.Do
//
//  Created by Dave Hurley on 2016-03-29.
//  Copyright © 2016 Dave Hurley. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }



    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = cellForTableView(tableView)
        cell.textLabel!.text = "List \(indexPath.row)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowChecklist", sender: nil)
    }
    
    // MARK: - Functions
    
    func cellForTableView(tableView: UITableView) -> UITableViewCell {
        
        let cellIndentifier = "Cell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier) {
            return cell
        } else {
            return UITableViewCell(style: .Default, reuseIdentifier: cellIndentifier)
        }
    }


}
