//
//  Checklist.swift
//  Every.Do
//
//  Created by Dave Hurley on 2016-03-29.
//  Copyright © 2016 Dave Hurley. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    
    var name = ""
    var lists: [Checklist]
    
    
    init(name: String) {
        self.name = name
        super.init()
    }
    

}
