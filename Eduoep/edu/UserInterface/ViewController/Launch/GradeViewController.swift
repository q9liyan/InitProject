//
//  GradeEOBaseViewController.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class GradeViewController: EOBaseViewController {
    var collectionTagView = EOCollectionTagView()
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
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionTagView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp_topMargin)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.snp_bottomMargin).offset(-(bottomSafeAreaHeight + 44))
        }
        
        
    }
   

}
