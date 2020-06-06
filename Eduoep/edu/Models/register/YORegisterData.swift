//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import HandyJSON

@objcMembers
 class YORegisterData : NSObject,HandyJSON{
	var fullUser : YOFullUserModel?
	var messaging : JRDetailModelModel?
    var token : String?
    
    required override init() {
        
    }
    
}
