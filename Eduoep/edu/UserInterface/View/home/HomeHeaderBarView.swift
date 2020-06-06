//
//  HomeTopBarView.swift
//  Eduoep
//
//  Created by apple on 2020/6/4.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HomeHeaderBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class HomeHeaderMoreView: UIView {
    var stackView: UIStackView?
    let titleView = HeaderMoreTitleView()
    var addBtn = UIButton()
    var items = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(addBtn)
        addSubview(titleView)
        items = ["英语","教学","语文"]
        createStatckView()
    }
    
    func createStatckView() {
        var views = [UIView]()
        var index = 0
        items.forEach{
            let label = UILabel()
            label.text = $0
            label.tag = 0001 + index
            index = index + 1
            views.append(label)
        }
        
        stackView = UIStackView(arrangedSubviews: views)
        stackView?.distribution = .equalSpacing
        stackView?.axis = .horizontal
        stackView?.spacing = 4
        stackView?.backgroundColor = UIColor.clear
        
        addSubview(stackView!)
    }
    
    override func layoutSubviews() {
        titleView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
        }
        
        addBtn.snp.makeConstraints { (make) in
                 make.right.equalTo(self.snp.right).offset(-8)
                 make.height.width.equalTo(44)
                 make.centerY.equalToSuperview()
             }
        
        stackView?.snp.makeConstraints({ (make) in
            make.left.equalTo(titleView.snp.left).offset(8)
            make.right.equalTo(addBtn.snp.left).offset(-8)
            make.height.equalToSuperview()
        })
        
     
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HeaderMoreTitleView: UIView{
    let titleLabel = UILabel()
    let underline  = UIImageView()
    override init(frame: CGRect) {
          super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
