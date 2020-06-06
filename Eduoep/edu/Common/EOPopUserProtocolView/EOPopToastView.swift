//
//  EOPopToastView.swift
//  Eduoep
//
//  Created by apple on 2020/6/6.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class EOPopToastView: UIView {

    let bgView = UIView()
    let cancelBtn = UIButton()
    var popProtocolView = EOPopToastContentView()
    
    typealias AgreeClosure = ()->()
    var agreeClosure: AgreeClosure?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(type: ToastContentType) {
        self.init()
        if type == .userProtocol {
            popProtocolView = EOPopProtocolContentView()
        }
        
        addSubview(bgView)
        addSubview(cancelBtn)
        addSubview(popProtocolView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        popProtocolView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 270, height: 309))
        }
    }
}
