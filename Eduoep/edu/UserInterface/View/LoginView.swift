//
//  LoginView.swift
//  Eduoep
//
//  Created by apple on 2020/6/3.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

@objc enum EOPhoneType :Int{
    case EOPhoneTypeLogin//登录
    case EOPhoneTypeBind//绑定
    case EOPhoneTypeChange//更换手机
}

class LoginView: UIView {
    var textBgView = UIView()                       // 内容框
    var iconArrowImageView = UIImageView()          // 地区编号箭头
    var mobileTextField = MBaseTextField()          // 手机号输入框
    var codeTextField = MBaseTextField()            // 验证码输入框
    var getCodeBtn = UIButton(frame: .zero)     // 获取验证码
    var loginBtn = UIButton(frame: .zero)       // 登录按钮
    var areaBtn = UIButton()                        // 地区编号按钮
    var verifyCodeLab =  UILabel()                  // 验证码title
    
    //定时器
    var timer:DispatchSourceTimer?
    var timerOver:Bool = true //定时器是否走完
    @objc var phoneType:EOPhoneType = .EOPhoneTypeLogin
    
    var urlOfSendSms:String?
    var urlOfAction:String?
    
    let separatorLabel = UILabel()
    let separatorLabel1 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textBgView)
        [mobileTextField,codeTextField,iconArrowImageView,getCodeBtn,loginBtn,areaBtn,verifyCodeLab,separatorLabel].forEach{
            textBgView.addSubview($0)
        }
    }
    
    func loadView() {
        separatorLabel.backgroundColor = UIColor.black
        separatorLabel1.backgroundColor = UIColor.black
        
        loginBtn.str(NSLocalizedString("", comment: "")).color("")
        verifyCodeLab.str(NSLocalizedString("", comment: "")).fontWeight(12)
        
        codeTextField.maxCount = 6
        codeTextField.placeholder = NSLocalizedString("", comment: "")
        mobileTextField.placeholder = NSLocalizedString("", comment: "")
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        textBgView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(120)
        }
        
        areaBtn.snp.makeConstraints { (make) in
            
            make.height.equalTo(60)
            make.left.equalTo(textBgView.snp.left).offset(16)
            make.right.equalTo(mobileTextField.snp.left).offset(9)
            make.top.equalToSuperview()
        }
        
        getCodeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(textBgView.snp.right).offset(-16)
            make.height.equalTo(60)
            make.width.equalTo(120)
            make.centerY.equalTo(areaBtn.snp.centerY)
        }
        
        iconArrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(areaBtn.snp.centerY)
            make.width.height.equalTo(18)
            make.left.equalTo(areaBtn.snp.right).offset(9)
        }
        
        mobileTextField.snp.makeConstraints { (make) in
            make.left.equalTo(iconArrowImageView.snp.right).offset(9)
            make.right.equalTo(getCodeBtn.snp.left)
            make.height.equalTo(25)
        }
        
        
        separatorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(areaBtn.snp.bottom).offset(9)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
      
        
        
        
        
    }
    
       //倒计时
     func stopTimer() {
         timer?.cancel()
         timerOver = true
         
        if mobileTextField.text?.isEmpty ?? true {
             self.getCodeBtn.isEnabled = false
         }else{
             self.getCodeBtn.isEnabled = true
         }
         self.getCodeBtn.str("发验证码")
     }
}
