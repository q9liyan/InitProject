//
//  EOYapDatabaseObject.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import HandyJSON
class EOYapDatabaseObject: NSObject, HandyJSON{
    var uniqueId = ""
    required override init() {
        
    }
    
    init(uniqueId: String) {
        super.init()
        self.uniqueId = uniqueId
    }
    
    func save() {
        
    }
    
    class func dbReadWriteConnection(){
        
    }
    
}
