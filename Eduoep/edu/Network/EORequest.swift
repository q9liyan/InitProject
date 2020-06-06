//
//  EORequest.swift
//  Eduoep
//
//  Created by apple on 2020/6/1.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire

@objc enum HttpRequestType : Int{
    case get
    case post
}

class optionalParamsModel: NSObject {
    // URL是否需要拼接，默认需要
    var urlJoint: Bool = false
    // 是否显示正在加载中蒙版 默认显示
    var showLoading: Bool = true
    // 请求超时时间，默认10s
    var timeoutInterval: CGFloat = 10
    // 网络异常时是否需要提示错误（404，415等）默认值 true
    var netErrorToast = true
    // 请求正常200，接口层面的错误是否需要提示错误 默认true
    var showFailureToast = true
    // 是否需要在请求的时候自动添加token和参数加密 默认是需要true
    var isNeedToAddToken = true
    
    override init() {
        super.init()
    }
}

@objcMembers
class EORequest: NSMutableURLRequest,URLRequestConvertible {
    // URLRequestConvertible 协议方法
    func asURLRequest() throws -> URLRequest {
        return self as URLRequest
    }
    // 请求类型
    private var requestType: HttpRequestType = .post
    // 请求参数体
    var parameters = [String : Any]()
    // 请求过程中其他设置
    var optionalParams = optionalParamsModel()
    
    convenience init(url: NSURL){
        self.init(url: url)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(url: NSURL,methodType: HttpRequestType,parameters: [String: Any]? = nil) {
        self.init(url: url)
        if parameters != nil {
            self.parameters = parameters!
        }
        self.requestType = methodType
        let method = methodType == .get ? "GET" : "POST"
        self.httpMethod = method
    }
    
    class func newEoRequest(urlString: EOApi, type: HttpRequestType? = .get, parameters: [String: Any]? = nil) -> EORequest {
    
        let request = EORequest(url: NSURL(string: urlString.rawValue)! , methodType: type!, parameters: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        var languageCode = NSLocale.current.languageCode!
//               let currentLanguage = NSLocale.preferredLanguages.first!
//               if currentLanguage.contains("zh-Hans") {
//                   languageCode = "zh_CN"
//               } else if currentLanguage.contains("zh-Hant") {
//                   languageCode = "zh_TW"
//               } else {
//                   languageCode = "en"
//               }
//        request?.setValue(languageCode, forHTTPHeaderField: "Language")
        
         return request
        
    }
  
    class func parametersFunc(parameters:[String : Any]) -> ([String : Any]) {
        
        let infoDictionary : Dictionary = Bundle.main.infoDictionary!
        //版本号
        let majorVersion :String = infoDictionary ["CFBundleShortVersionString"] as! String
        //build号
        let minorVersion :String = infoDictionary ["CFBundleVersion"] as! String
        
        let allParameters:[String : Any] = ["build":minorVersion,
                                            "token": YORegisterDataMgr.shared.token() ?? "",
                                            "device":"iPhone",
                                            "params":parameters,
                                            "platform":"iOS",
                                            "subChannel":"",
                                            "uid":YORegisterDataMgr.shared.uid() ?? 0,
                                            "version":majorVersion]
        
        return allParameters;
    }
}

