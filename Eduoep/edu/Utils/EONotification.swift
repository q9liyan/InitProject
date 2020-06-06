//
//  EONotification.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxSwift

enum EONotification: String {

    case login
    
    var stringValue: String {
        return "EO" + rawValue
    }
    
    var notificationName: NSNotification.Name {
        return NSNotification.Name(rawValue: stringValue)
    }
    
}

public extension Notification.Name {
    static let YapDatabaseModifiedNotification = Notification.Name("YapDatabaseModifiedNotification")
    
    
    static let EOResetStorageNotification = Notification.Name("EOResetStorageNotification")
}

extension NotificationCenter {
    static func post(customeNotification name: EONotification, object: Any? = nil){
        NotificationCenter.default.post(name: name.notificationName, object: object)
    }
}

extension Reactive where Base: NotificationCenter {
    func notification(custom name: EONotification, object: AnyObject? = nil) -> Observable<Notification> {
        return notification(name.notificationName, object: object)
    }
}
