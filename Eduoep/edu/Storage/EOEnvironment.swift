//
//  EOEnvironment.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class EOEnvironment: NSObject {
 
    private var _primaryStorage: EOPrimaryStorage?
    private var _registerDataManager: YORegisterDataMgr?
    
    static let shared = EOEnvironment()
    
    var primaryStorage: EOPrimaryStorage {
        get {
            return _primaryStorage!
        }
    }
    
    var registerDataManager: YORegisterDataMgr {
        get{
            return _registerDataManager!
        }
    }
    
    override init(){
       
    }
    
    func configure(primaryStorage: EOPrimaryStorage,registerDataManager: YORegisterDataMgr) {
        _primaryStorage = primaryStorage
        _registerDataManager = registerDataManager
        
    }
    
    
}
