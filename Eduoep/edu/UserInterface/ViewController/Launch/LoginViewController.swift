//
//  LoginViewController.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class LoginViewController: EOBaseViewController {
    
    let loginView = LoginView()
    let otherLoginNoteView = UIView()
    let loginToolBarView = LoginToolBarView()
    let privacyNoteLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        view.addSubview(loginToolBarView)
        view.addSubview(privacyNoteLabel)
        setupView()
        privacyNoteLabel.textAlignment = .center
        
        let all:String = "登录即视为同意《用户隐私声明》和《用户服务协议》"
        let att = AttStr(all).font(11).color("#999999")

        att.select("《用户隐私声明》").linkColor("black").link()
        att.select("《用户服务协议》").linkColor("black").link()
        privacyNoteLabel.isUserInteractionEnabled = true
        privacyNoteLabel.attributedText = att
        privacyNoteLabel.onLink { (txt) in
            if txt == "《用户隐私声明》" {

            }else{

            }

        }
    }
    
    func setupView() {
        
        loginView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(150)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(300)
        }
        
        privacyNoteLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom)
            make.width.centerX.equalToSuperview()
            make.height.equalTo(25)
            
        }
        
        createOtherNoteView()
        
        loginToolBarView.snp.makeConstraints { (make) in
            make.top.equalTo(otherLoginNoteView.snp.bottom).offset(9)
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.centerX.equalToSuperview()
        }
        
        privacyNoteLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-9)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
        }
        
    }
    
    func createOtherNoteView() {
        
        let leftLineLabel = UILabel()
        let rightLineLabel = UILabel()
        let noteLabel = UILabel ()
        
        view.addSubview(otherLoginNoteView)
        otherLoginNoteView.snp.makeConstraints { (make) in
            make.top.equalTo(loginView.snp.bottom).offset(9)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        [leftLineLabel,noteLabel,leftLineLabel,rightLineLabel].forEach{
            otherLoginNoteView.addSubview($0)
        }
        
        noteLabel.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
        }
        
        leftLineLabel.snp.makeConstraints { (make) in
            make.right.equalTo(noteLabel.snp.left).offset(-9)
            make.width.equalTo(80)
            make.height.equalTo(0.5)
            make.centerY.equalToSuperview()
        }
        
        rightLineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(noteLabel.snp.right).offset(9)
            make.width.equalTo(80)
            make.height.equalTo(0.5)
            make.centerY.equalToSuperview()
        }
        leftLineLabel.backgroundColor = UIColor.gray
        rightLineLabel.backgroundColor = UIColor.gray
        noteLabel.str(NSLocalizedString("", comment: "")).fontWeight(12)
    }
    
}
