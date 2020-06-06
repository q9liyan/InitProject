//
//  HomeShopFilterViewController.swift
//  Eduoep
//
//  Created by apple on 2020/6/5.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ShopFilterViewController: UIViewController {
    var collectionTagView = EOCollectionTagView()   // 标签集合试图
    var confirmBtn = UIButton() // 确定按钮
    let switchView = UISwitch() // switch开关
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tagModel1 = EOCollectionTagModel()
        tagModel1.sectionTitle = "小学"
        tagModel1.itemTitles = ["小一","小二","小三","小四","小五"]
        
        let tagModel = EOCollectionTagModel()
        tagModel.sectionTitle = "中学"
        tagModel.itemTitles = ["小一","小二","小三","小四","小五"]
        
        collectionTagView.configuerModels(models: [tagModel1,tagModel])
        
        view.addSubview(collectionTagView)
        view.addSubview(confirmBtn)
        view.addSubview(switchView)
        
        log.debug()
        
        setupView()
    }
    
    func setupView() {
        
        confirmBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-20)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.height.equalTo(41)
        }
        
        switchView.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp.right).offset(-16)
            make.size.equalTo(CGSize(width: 45, height: 23))
            make.bottom.equalTo(confirmBtn.snp.top).offset(-20)
        }
        
        let switchLabel = UILabel()
        view.addSubview(switchLabel)
        
        switchLabel.str(NSLocalizedString("僅顯示有優惠活動", comment: "")).fontWeight(12).color(UIColor.rgbHex(0x999999))
       
        
        switchLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(switchView.snp.centerY)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(switchView.snp.left)
            make.height.equalTo(switchView.snp.height)
        }
        
        collectionTagView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(switchView.snp.top)
        }
    }
    
}
