//
//  LoginModelViewController.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class LoginModelViewController: EOBaseViewController {
    let loginIconImageView = UIImageView()
    let loginTitleBtn = UIButton()
    let moreLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [loginIconImageView,loginTitleBtn,moreLabel].forEach{
            view.addSubview($0)
        }
        
        let loginTitle = isFaceIdDevice() ? NSLocalizedString("LOGIN_MODEL_FACEID", comment: "") : NSLocalizedString("LOGIN_MODEL_TOUCHID", comment: "")
        loginTitleBtn.setTitle(loginTitle, for: .normal)
        moreLabel.text = NSLocalizedString("APP_MORE", comment: "")
    }
    
    
    
    func laodView() {
        loginIconImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view).offset(-16)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        loginTitleBtn.snp.makeConstraints { (make) in
            make.top.equalTo(loginIconImageView.snp_bottomMargin)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(25)
        }
        
        moreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(loginTitleBtn.snp_bottomMargin)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(25)
        }
    }
    
    func isFaceIdDevice() -> Bool{
        return BioMetricAuthenticator.shared.isFaceIdDevice()
        
    }
    

 

}
