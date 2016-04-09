//
//  ChecklistItem.swift
//  Every.Do
//
//  Created by Dave Hurley on 2016-03-22.
//  Copyright © 2016 Dave Hurley. All rights reserved.
//

import Foundation
import UIKit

class ChecklistItem: NSObject, NSCoding {
    
    var text = ""
    var checked = false
    var dueDate = NSDate()
    var shouldRemind = false
    var itemID: Int
    
    func toggleChecked() {
        checked = !checked
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        text = aDecoder.decodeObjectForKey("Text") as! String
        checked = aDecoder.decodeBoolForKey("Checked")
        dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
        shouldRemind = aDecoder.decodeBoolForKey("ShouldRemind")
        itemID = aDecoder.decodeIntegerForKey("ItemID")
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
        aCoder.encodeObject(dueDate, forKey: "DueDate")
        aCoder.encodeBool(shouldRemind, forKey: "ShouldRemind")
        aCoder.encodeInteger(itemID, forKey: "ItemId")
    }
    
    
    override init() {
        
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
    func notificationForThisItem() -> UILocalNotification? {
        
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications!
        for notification in allNotifications {
            if let number = notification.userInfo?["ItemID"] as? Int where number == itemID {
                return notification
            }
        }
        return nil
    }
    
    func scheduleNotification() {
        
        let existingNotification = notificationForThisItem()
        if let notification = existingNotification {
            print("found existing notification \(notification)")
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
        
        if shouldRemind && dueDate.compare(NSDate()) != .OrderedAscending {
            let localNotification = UILocalNotification()
            localNotification.fireDate = dueDate
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = text
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.userInfo = ["ItemID": itemID]
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
            print("scheduled localNotification \(localNotification) for itemID \(itemID)")
        }
    }
    
    deinit {
        
        if let notification = notificationForThisItem() {
            print("removing existing notifiction \(notification)")
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
    }
}