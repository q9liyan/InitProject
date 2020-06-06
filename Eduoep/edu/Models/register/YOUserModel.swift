//
//	User.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import HandyJSON

@objcMembers
class YOUserModel : NSObject,HandyJSON{
    
    // 对该类的实例或者实例成员gender,head,name赋值后，顺便调用下JRRegisterDataMgr.shared.saveSelf()
    var gender : String?{
        didSet{
           
        }
    }
    var head : String?{
        didSet{
        }
    }
    var name : String?{
        didSet{
            
        }
    }
    
	var glamourLabel : YOGlamourLabelModel?
	var richLabel : YOGlamourLabelModel?
	var shortId : Int = 0
	var uid : Int = 0
	var vipHeadboxUrl : String?
	var vipLabel : YOGlamourLabelModel?
    var vipLevel : String?
    
    @objc var labelUrlList : [String]?
    
    var follow:Bool = false
    
    var glamourLevel : Int = 0
    var richLevel : Int = 0
    
    required override init() {
        
    }
    
}
