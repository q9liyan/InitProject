//
//  AppDelegate.swift
//  Eduoep
//
//  Created by apple on 2020/6/1.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Bugly
@_exported import XCGLogger
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let _xcode_workaround_log: XCGLogger = {
    let log = XCGLogger.default
    // Create a destination for the system console log (via NSLog)
    let systemDestination = AppleSystemLogDestination(identifier: "advancedLogger.appleSystemLogDestination")

    // Optionally set some configuration options
    systemDestination.outputLevel = .debug
    systemDestination.showLogIdentifier = false
    systemDestination.showFunctionName = true
    systemDestination.showThreadName = true
    systemDestination.showLevel = true
    systemDestination.showFileName = true
    systemDestination.showLineNumber = true
    
    // Add the destination to the logger
    log.add(destination: systemDestination)

    // Create a file log destination
    let logPath: URL = appDelegate.cacheDirectory.appendingPathComponent("XCGLogger_Log.txt")
    let autoRotatingFileDestination = AutoRotatingFileDestination(writeToFile: logPath, identifier: "advancedLogger.fileDestination", shouldAppend: true,
                                                                    attributes: [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication], // Set file attributes on the log file
                                                                    maxFileSize: 1024 * 5, // 5k, not a good size for production (default is 1 megabyte)
                                                                    maxTimeInterval: 60, // 1 minute, also not good for production (default is 10 minutes)
                                                                    targetMaxLogFiles: 20) // Default is 10, max is 255

      // Optionally set some configuration options
      autoRotatingFileDestination.outputLevel = .debug
      autoRotatingFileDestination.showLogIdentifier = false
      autoRotatingFileDestination.showFunctionName = true
      autoRotatingFileDestination.showThreadName = true
      autoRotatingFileDestination.showLevel = true
      autoRotatingFileDestination.showFileName = true
      autoRotatingFileDestination.showLineNumber = true
      autoRotatingFileDestination.showDate = true

      // Process this destination in the background
      autoRotatingFileDestination.logQueue = XCGLogger.logQueue
    
    // Add the destination to the logger
    log.add(destination: autoRotatingFileDestination)

    // Add basic app info, version info etc, to the start of the logs
    log.logAppDetails()
    
    return log
}()

let log: XCGLogger = _xcode_workaround_log





@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let singleLoginManager: SingleLoginManager = SingleLoginManager()
    let tabbrController = EOBaseTabBarController()
    
    let cacheDirectory: URL = {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow.init()
        window.frame = UIScreen.main.bounds
        let mainVC = ShopFilterViewController()
        window.rootViewController = tabbrController
        self.window = window
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = UIColor.white
        
        // 谷歌 facebook 登录
        singleLoginManager.setupAllLoginID()
        
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
        
        configBugly()
        

       
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // FB登录 open url
        ApplicationDelegate.shared.application( app, open: url,
                                                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
    }
    
}

extension AppDelegate {
    
    /// 配置bugly
    func configBugly() {
        let confige = BuglyConfig()
        // debug 信息开关
        confige.debugMode = false
        // 日志上报类型
        confige.reportLogLevel = BuglyLogLevel.warn
        confige.channel = "Eduoep"
        
        Bugly.start(withAppId: "bugly appid")
        // 用户标识
        Bugly.setUserIdentifier(UIDevice.current.name)
        // 设备id
        Bugly.buglyDeviceId()
    }
    
    func configLog() {
   
    }
}

