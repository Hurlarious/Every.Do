//
//  ChecklistItem.swift
//  Every.Do
//
//  Created by Dave Hurley on 2016-03-22.
//  Copyright © 2016 Dave Hurley. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}