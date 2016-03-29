//
//  ItemDetailViewController.swift
//  Every.Do
//
//  Created by Dave Hurley on 2016-03-23.
//  Copyright © 2016 Dave Hurley. All rights reserved.
//

import Foundation
import UIKit



// MARK: - Delegate Protocols

protocol ItemDetailViewControllerDelegate: class {
 
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}


class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Variables/Properties/Outlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
    // MARK: - Table view data source
    
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
        
        if let item = itemToEdit {
            
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
            
        } else {
            
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishAddingItem: item)
        }
    }
    
    @IBAction func cancelPressed() {
        
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    


}