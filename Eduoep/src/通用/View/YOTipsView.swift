//
//  YOTipsView.swift
//  JRLive
//
//  Created by xxsskk on 2019/12/14.
//  Copyright © 2019 xxsskk. All rights reserved.
//

import UIKit


//enum JRTipsType:Int {
//    case JRTipsTypeTwoBtn = 0
//    case JRTipsTypeOneBtn
//}
@objcMembers

class YOTipsView: UIView,NibLoadable {
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var msgLab: UILabel!
    @IBOutlet weak var cancelBtn: UniversalBtn!
    @IBOutlet weak var okBtn: UniversalBtn!
    @IBOutlet weak var longBtn: UniversalBtn!
//    var tipsType:JRTipsType = .JRTipsTypeTwoBtn{
//        willSet{
//            switch newValue {
//            case .JRTipsTypeTwoBtn:
//
//            case .JRTipsTypeOneBtn:
//            default:
//                <#code#>
//            }
//        }
//    }
    
    
    typealias Btnlosure = ()->()
    var cancelClosure:Btnlosure?
    var okClosure:Btnlosure?
    var longBtnClosure:Btnlosure?
    @objc open class func showTwoBtn(_ superView:UIView!, _ title:String?, _ msg:String?,_ cancel:String?,_ ok:String?,_ cancelClosure:Btnlosure?,_ okClosure:Btnlosure?){
        let v = YOTipsView.loadFromNib()
        v.titleLab.str(title)
        v.msgLab.str(msg)
        v.cancelBtn.str(cancel)
        v.okBtn.str(ok)
        v.longBtn.isHidden = true
        v.cancelClosure = cancelClosure
        v.okClosure = okClosure
        superView.addSubview(v)
        v.makeCons { (make) in
            make.edge.equal(superView as Any)
        }
    }
    @objc open class func showOneBtn(_ superView:UIView!, _ title:String?, _ msg:String?,_ longBtnTitle:String?,_ longBtnClosure:Btnlosure?){
        let v = YOTipsView.loadFromNib()
        v.titleLab.str(title)
        v.msgLab.str(msg)
        v.cancelBtn.isHidden = true
        v.okBtn.isHidden = true
        v.longBtnClosure = longBtnClosure
        v.longBtn.str(longBtnTitle)
        v.msgLab.color("#888888")
        superView.addSubview(v)
        v.makeCons { (make) in
            make.edge.equal(superView as Any)
        }
    }
    @objc open class func showNoBtn(_ superView:UIView!, _ title:String?, _ msg:String?,_ longBtnClosure:Btnlosure?){
        let v = YOTipsView.loadFromNib()
        v.titleLab.str(title)
        v.msgLab.str(msg)
        v.cancelBtn.isHidden = true
        v.okBtn.isHidden = true
        v.longBtnClosure = longBtnClosure
        v.longBtn.isHidden = true
        v.msgLab.color("#888888")
        superView.addSubview(v)
        v.makeCons { (make) in
            make.edge.equal(superView as Any)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let color = UIColor.black.withAlphaComponent(0.6)
        self.bg(color)
        titleLab.color("black")
        msgLab.color("#666666")
        cancelBtn.useForMain = false
        okBtn.useForMain = true
        cancelBtn.font(14)
        okBtn.font(14)
        longBtn.font("14")
        cancelBtn.onTap {
            self.removeFromSuperview()
            if let closure = self.cancelClosure{
                closure()
            }
        }
        okBtn.onTap {
            self.removeFromSuperview()
            if let closure = self.okClosure{
                closure()
            }
        }
        longBtn.onTap {
            self.removeFromSuperview()
            if let closure = self.longBtnClosure{
                closure()
            }
        }
        self.onTap {
            self.removeFromSuperview()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
