//
//  FBloginController.swift
//  Eduoep
//
//  Created by apple on 2020/6/3.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit


class FBLoginControllerView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let loginButton = FBLoginButton(type: .custom)
            loginButton.defaultAudience = .everyone
            loginButton.center = self.center
            self.addSubview(loginButton)
            loginButton.addTarget(self, action: #selector(beginLogin), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    @objc
    func beginLogin(from viewController: UIViewController?) {
        LoginManager.init().logIn(permissions: ["public_profile"],
                                  from: viewController) { (result, error) in
                                    if let error = error {
                                        
                                    }else if result?.isCancelled ?? true {
                                        
                                    }else {
                                        
                                    }
        }
        
        
    }
    
    
    
    
}


