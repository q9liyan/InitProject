//
//  YORegisterDataMgr.swift
//  JRLive
//
//  Created by xxsskk on 2019/11/29.
//  Copyright © 2019 xxsskk. All rights reserved.
//

import UIKit
let kJRRegisterData = "YORegisterData"

@objcMembers
class YORegisterDataMgr: NSObject {
    
    var model:YORegisterData?{
        willSet{
            if let noNil = newValue {
                writeUserToSandbox(noNil)
            }else{
                removeUser()
            }
        }
    }
    
    static let shared: YORegisterDataMgr = {
           let instance = YORegisterDataMgr()
           return instance
       }()
    
    override init() {
        super.init()
        let data = (UserDefaults.standard.object(forKey:kJRRegisterData ) as? String)
        if (data != nil) {
            self.model = YORegisterData.deserialize(from: data)
        }else{
            self.model = nil;
        }
    }
    func saveSelf(){
        let data:String = self.model?.toJSONString(prettyPrint: true) ?? ""
        UserDefaults.standard.set(data, forKey: kJRRegisterData)
        UserDefaults.standard.synchronize()
    }
    //保存用户数据
    func writeUserToSandbox(_ user:YORegisterData){
        let data:String = user.toJSONString(prettyPrint: true) ?? ""
        UserDefaults.standard.set(data, forKey: kJRRegisterData)
        UserDefaults.standard.synchronize()
    }
    //移除用户数据
     func removeUser(){
        UserDefaults.standard.removeObject(forKey: kJRRegisterData)
        UserDefaults.standard.synchronize()
      
    }

    //获取uid
    func uid() -> Int {
        return self.model?.fullUser?.user?.uid ?? 0
    }
    
    //获取头像url
    func head() -> String?{
        return self.model?.fullUser?.user?.head
    }
    func token() -> String?{
        return self.model?.token
    }

}
