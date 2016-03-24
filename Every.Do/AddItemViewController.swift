//
//  AddItemViewController.swift
//  Every.Do
//
//  Created by Dave Hurley on 2016-03-23.
//  Copyright © 2016 Dave Hurley. All rights reserved.
//

import Foundation
import UIKit


class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Variables/Properties/Outlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    
    // MARK: Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
    // MARK: - Table View Functions
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        return nil
    }
    
    // MARK: - Functions
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneButton.enabled = (newText.length > 0)
        return true
    }
    
    
    // MARK: - Actions
    
    @IBAction func donePressed() {
        
        print("contents of text field: \(textField.text!)")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelPressed() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}