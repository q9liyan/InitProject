//
//  YOMacro.swift
//  JRLive
//
//  Created by xxsskk on 2019/11/21.
//  Copyright © 2019 xxsskk. All rights reserved.
//

import Foundation

//当前系统版本
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue
//      屏幕宽度
let ScreenWidth = UIScreen.main.bounds.width
//屏幕高度
let ScreenHeight = UIScreen.main.bounds.height

let myAppDelegate = UIApplication.shared.delegate as! AppDelegate

//状态栏高度
let statusBarHeight = UIApplication.shared.statusBarFrame.height;

//导航栏高度
let navigationHeight = (statusBarHeight + 44)

//tabbar高度
let tabBarHeight = (statusBarHeight==44 ? 83 : 49)

//顶部的安全距离
let topSafeAreaHeight = (statusBarHeight - 20)

//底部的安全距离
let bottomSafeAreaHeight = (tabBarHeight - 49)


//MARK:--各种函数
func isIPhoneX() -> Bool {
    let isX = UIDevice.isPhoneX()
    return isX
}
func SafeAreaTopHeight() -> CGFloat {
    let h = UIDevice.ofSafeAreaTopHeight()
    return h
}
func SafeAreaTop() -> CGFloat {
    let h = UIDevice.ofSafeAreaTop()
    return h
}
func FitW(_ w:CGFloat) -> CGFloat {
    let fit = UIDevice.fitWidth(w)
    return fit
}
func FitH(_ h:CGFloat) -> CGFloat {
    let fit = UIDevice.fitHeight(h)
    return fit
}
func SafeAreaBottomHeight() -> CGFloat {
    let h = UIDevice.ofSafeAreaBottomHeight()
    return h
}
func Random(_ x:Int) -> Int {
    return Int(arc4random()) % (x)
}
func RandomNO0(_ x:Int) -> Int {
    return Int(arc4random()) % (x) + 1
}
func DIN_Alternate_Bold(_ x:CGFloat) -> UIFont {
    return UIFont(name: "DINAlternate-Bold", size: x) ?? UIFont.boldSystemFont(ofSize: x)
}
func DIN_BlackItalic(_ x:CGFloat) -> UIFont {
    return UIFont(name: "DIN-BlackItalic", size: x) ?? UIFont.boldSystemFont(ofSize: x)
}
func DIN_BoldItalic(_ x:CGFloat) -> UIFont {
    return UIFont(name: "DIN-BoldItalic", size: x) ?? UIFont.boldSystemFont(ofSize: x)
}

//字符串转json
func nsdataToJSON(data: Data) -> AnyObject? {
    do {
        return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as AnyObject
    } catch {
        print(error)
    }
    return nil
}

//json转字符串
func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
    if (!JSONSerialization.isValidJSONObject(dictionary)) {
        print("无法解析出JSONString")
        return ""
    }
    let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
    return JSONString! as String
}

func timeStampToCurrennTime(timeStamp: Double) -> String {
    //获取当前的时间戳
    let currentTime = Date().timeIntervalSince1970
    //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
   //let timeSta:TimeInterval = TimeInterval(timeStamp / 1000)
    //时间差
    let reduceTime : TimeInterval = currentTime - timeStamp
    //时间差小于60秒
    if reduceTime < 60 {
        return "刚刚"
    }
    //时间差大于一分钟小于60分钟内
    let mins = Int(reduceTime / 60)
    if mins < 60 {
        return "\(mins)分钟前"
    }
    //时间差大于一小时小于24小时内
    let hours = Int(reduceTime / 3600)
    if hours < 24 {
        return "\(hours)小时前"
    }
    //时间差大于一天小于30天内
    let days = Int(reduceTime / 3600 / 24)
    if days < 30 {
        return "\(days)天前"
    }
    //不满足以上条件直接返回日期
    let date = NSDate(timeIntervalSince1970: timeStamp)
    let dfmatter = DateFormatter()
    //yyyy-MM-dd HH:mm:ss
    dfmatter.dateFormat="yyyy-MM-dd"
    return dfmatter.string(from: date as Date)
}

//MARK:--各种默认占位图

let DefaultHeaderImg:UIImage = Img("pic_default_head")
let DefaultBannerImg:UIImage = Img("pic_default_banner")
let DefaultCoverImg:UIImage = Img("pic_default_cover")
let DefaultFollowImg:UIImage = Img("pic_default_follow")
let DefaultLiveImg:UIImage = Img("pic_default_live")
let DefaultNetworkImg:UIImage = Img("pic_default_network")
let DefaultNothingImg:UIImage = Img("pic_default_nothing")
let LogoImg:UIImage = Img("me_logo")


