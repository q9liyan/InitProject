//
//  EOPrimaryStorage.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import YapDatabase

class EOPrimaryStorage: EOStorage {
    static let shared = EOPrimaryStorage()
    var uiDatabaseConnection: YapDatabaseConnection?
    var dbReadWriteConnection: YapDatabaseConnection?
    var dbReadConnection: YapDatabaseConnection?
    
    override init() {
        super.init()
        uiDatabaseConnection = self.database?.newConnection()
        dbReadWriteConnection = self.database?.newConnection()
        dbReadConnection = self.database?.newConnection()
        
        NotificationCenter.default.addObserver(self,selector: #selector(yapDatabaseModified(notification:)),name: NSNotification.Name.YapDatabaseModified,
        object: self.dbNotificationObject())
        
    }
    
    @objc
    func yapDatabaseModified(notification: Notification) {
        
    }
}
