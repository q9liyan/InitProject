//
//  EduApp.swift
//  Eduoep
//
//  Created by apple on 2020/6/1.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation


@_exported import SnapKit
enum LoginModel {
    case wechat
    case faceID
    case touchID
    case facebook
    case goole
    case none
}

class EduApp {
    static let shared = EduApp()
    var loginModel: LoginModel = .none
    
    
    class func setupEnvironment(singletonBlock: () -> Void, migrationCompletion: () -> Void) {
       
        
    }
    
}
