//
//  LoginToolBar.swift
//  Eduoep
//
//  Created by apple on 2020/6/3.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class LoginToolBarView: UIView {
    let googleBtn = UIButton()  //  谷歌登录按钮
    let facebookBtn = UIButton()    // facebook登录按钮
    let wechatBtn = UIButton()  // 微信登录
    let contentView = UIView()  // 内容container
    
    var canDeviceLogin = true
    
    let deviceLoginLabel = YYLabel()
    let deviceNoteLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
        
        [googleBtn,facebookBtn,wechatBtn].forEach({
            contentView.addSubview($0)
        })
        
        googleBtn.setImage(UIImage(named: ""), for: .normal)
        facebookBtn.setImage(UIImage(named: "facebook"), for: .normal)
        wechatBtn.setImage(UIImage(named: ""), for: .normal)
        
        deviceLoginLabel.textAlignment = .center
        deviceNoteLabel.textAlignment = .center
        
        if canDeviceLogin {
            contentView.addSubview(deviceLoginLabel)
            contentView.addSubview(deviceNoteLabel)
            let deviceLoginTitle = String.init(format: NSLocalizedString("切换为 %@ 登录", comment: ""), NSLocalizedString("面容ID ", comment: ""))
            let atext = NSMutableAttributedString(string: deviceLoginTitle)
            
            deviceLoginLabel.setUnderline(attributedString: deviceLoginTitle, rang: atext.yy_rangeOfAll())
            deviceNoteLabel.str(NSLocalizedString("", comment: "")).fontWeight(12)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        facebookBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.top).offset(8)
            make.width.height.equalTo(80)
        }
        
        googleBtn.snp.makeConstraints { (make) in
            make.right.equalTo(facebookBtn.snp.left).offset(-9)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.width.height.equalTo(80)
        }
        
        wechatBtn.snp.makeConstraints { (make) in
            make.left.equalTo(facebookBtn.snp.right).offset(9)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.width.height.equalTo(80)
        }
        
        deviceLoginLabel.snp.makeConstraints { (make) in
            make.top.equalTo(facebookBtn.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(25)
        }
        
        deviceNoteLabel.snp.makeConstraints { (make) in
            make.top.equalTo(deviceLoginLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(25)
        }
        
        
    }
    
    
    
}
