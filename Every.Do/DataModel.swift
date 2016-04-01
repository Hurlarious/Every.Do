//
//  DataModel.swift
//  Every.Do
//
//  Created by Dave Hurley on 2016-04-01.
//  Copyright © 2016 Dave Hurley. All rights reserved.
//

import Foundation

class DataModel {
    
    var lists = [Checklist]()
    
    var indexOfSelectedList: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "ChecklistIndex")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    init() {
        loadChecklists()
        registerDefaults()
    }
    
    
    
    // MARK: - Functions
    
    func documentsDirectory() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String {
        
        let directory = documentsDirectory() as NSString
        return directory.stringByAppendingPathComponent("EveryDo.plist")
    }
    
    func saveChecklists() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadChecklists() {
        
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            
            if let data = NSData(contentsOfFile: path) {
                
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lists = unarchiver.decodeObjectForKey("Checklists") as! [Checklist]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func registerDefaults() {
        
        let dictionary = [ "ChecklistIndex": -1,
                           "FirstTime": true ]
        
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }

}