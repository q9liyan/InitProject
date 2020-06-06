//
//  EOPopToastContentView.swift
//  Eduoep
//
//  Created by apple on 2020/6/6.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

enum ToastContentType {
    case normal
    case userProtocol
    case image
}

protocol ToastContentItem {
    var type: ToastContentType { get }
}

class EOPopToastContentView: UIView, ToastContentItem {
    var type: ToastContentType {
        return .normal
    }
    
}

class EOPopImageContentView: EOPopToastContentView {
    override var type: ToastContentType {
          return .image
    }
}

class EOPopProtocolContentView: EOPopToastContentView {
    let titleBtn = UIButton()
    let contentTextView = UITextView()
    let disagreeBtn = UIButton()
    let protocolLabel = UILabel()
    
    override var type: ToastContentType {
        return .userProtocol
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        [titleBtn,contentTextView,disagreeBtn,protocolLabel].forEach{
            addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        titleBtn.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(49)
        }
        
        disagreeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(31)
            make.bottom.equalTo(self).offset(-15)
        }
        
        protocolLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(disagreeBtn.snp.top).offset(-5)
            make.left.right.equalToSuperview()
            make.height.equalTo(15)
        }
        
        contentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(titleBtn.snp.bottom).offset(10)
            make.left.right.equalTo(self)
            make.bottom.equalTo(protocolLabel.snp.top).offset(-15)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
