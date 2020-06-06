//
//	Privacy.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import HandyJSON

@objcMembers
class YOPrivacyModel : NSObject,HandyJSON{
	var bindPhone : Bool = false
	var birthday : Double = 0
    var jewel : Int = 0
    var phone : String? = ""
    var phoneAreaCode : String?
    var score : Int = 0
    var showGuild : Bool = false
    var showLive : Bool = false
	var showLocation : Bool = false
	var youth : Bool = false
	var youthPassphase : String?
    var authStatus:Int = 0
    
    required override init() {
        
    }
}
