//
//  EOStorage.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import YapDatabase




class EOStorage: NSObject {
    
    var database: YapDatabase?
    var extensionNames = [String]()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(resetStorage), name: NSNotification.Name.EOResetStorageNotification, object: nil)
    }
    
    func loadDatabase() {
        if !tryToLoadDatabase() {
            
        }
    }
    
    func tryToLoadDatabase() -> Bool {
        let options = YapDatabaseOptions()
        options.corruptAction = .fail
        options.enableMultiProcessSupport = true
        guard let database = YapDatabase.init(url: self.databasePath(), options: .none)  else {
            return false
        }
        self.database = database
        return true
    }
    
    
    func newDatabaseConnection() -> YapDatabaseConnection? {
        let dbConnection  = self.database?.newConnection()
        
        return dbConnection
    }
    
    func dbNotificationObject() -> Any? {
        return self.database
    }
    

}

extension EOStorage {
    @objc
    func resetStorage() {
        
    }
    
    func resetAllStorage() {
        
    }
    
    class func deleteDatabaseFiles() {
        
    }
}

extension EOStorage {
    
    func databasePath() -> URL {
          let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
          let baseDir = (paths.count > 0) ? paths[0] : NSTemporaryDirectory()
          let databaseName = "database.sqlite"
          return  URL(fileURLWithPath: baseDir).appendingPathComponent(databaseName)
      }
    
}
