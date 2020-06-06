//
//  EORequestManager.swift
//  Eduoep
//
//  Created by apple on 2020/6/1.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
import SwiftyJSON

/// 请求返回码类型
enum codeType: Int {
    case unknown
    case success = 200
}

@objc
class NetworkResponse: NSObject, HandyJSON {
    var code: Int?
    var result: String?
    var data: Any?
    
    required override init() {}
    class func codeAnalysis(jrmodel:NetworkResponse, sBlock:(_ model : NetworkResponse)->()) {
        
    }
}


@objcMembers
class EORequestManager: NSObject {
    
    typealias SuccessHandlerType = ((_ model:NetworkResponse) -> Void)
    typealias FailureHandlerType = ((_ jrCode:Int?,_ msg:String) ->Void)
    
    private var success: SuccessHandlerType?//成功的回调
    private var failure: FailureHandlerType?//失败的回调
    
    ///成功的回调
    func success(_ handler: @escaping SuccessHandlerType) -> Self {
        self.success = handler
        return self
    }
    
    ///失败的回调
    func failure(handler: @escaping FailureHandlerType) -> Self {
        self.failure = handler
        return self
    }
    
    
    /// 构建 URLRequest 对象方式 请求
    /// - Parameters:
    class func request(request: EORequest, success : @escaping (_ model : NetworkResponse)->(), failure : ((Int?, String) ->Void)?) {
        AF.request(request).response { (response) in
            guard let json = response.data else {
                return
            }
            switch response.result {
            case let .success(response):
                let jrmodel:NetworkResponse = self.analysis(response: response!)
                if (jrmodel.code == codeType.success.rawValue)  {
                    success(jrmodel)
                }else{
                    NetworkResponse.codeAnalysis(jrmodel: jrmodel) { (jrmodel) in
                        success(jrmodel)
                    }
                }
                
            case let .failure(error):
                failureHandle(failure: failure, stateCode: nil, message: error.localizedDescription)
            }
        }
        
        //错误处理 - 弹出错误信息
        func failureHandle(failure: ((Int?, String) ->Void)? , stateCode: Int?, message: String) {
            failure?(stateCode ,message)
        }
    }
    
    //可以封装一个解析方法
    class func analysis(response:Data) -> (NetworkResponse) {
        let model:NetworkResponse = NetworkResponse.deserialize(from: String(data: response, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))) ?? NetworkResponse()
        return model
    }
    
}
