//
//  HomeHeaderView.swift
//  Eduoep
//
//  Created by apple on 2020/6/4.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {

    let topBarView = HomeHeaderBarView()
    let headerBgView = UIImageView()
    let cycleView = ZCycleView()
    let moreView = HomeHeaderMoreView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(topBarView)
        addSubview(headerBgView)
        addSubview(cycleView)
        addSubview(moreView)
        cycleView.isInfinite = false
        cycleView.setUrlsGroup(["http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171101181927887.jpg",
        "http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171114171645011.jpg",
        "http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171114172009707.png"])
        cycleView.delegate = self
        cycleView.itemSize = CGSize(width: ScreenWidth-20, height: (ScreenWidth-160)*300/750)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        topBarView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(45)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(36)
        }
        
        headerBgView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(227)
        }
        
        cycleView.snp.makeConstraints { (make) in
            make.top.equalTo(topBarView.snp.bottom).offset(35)
            make.left.right.equalToSuperview()
            make.height.equalTo(144)
        }
        
        moreView.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(9)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
    }
}

extension HomeHeaderView: ZCycleViewProtocol {
    
    func cycleViewCustomCellClass() -> AnyClass {
        return EOCycleBannerCell.classForCoder()
    }
    
    func cycleViewConfigurePageControl(_ cycleView: ZCycleView, pageControl: ZPageControl) {
       
            pageControl.pageIndicatorTintColor = UIColor.green
            pageControl.currentPageIndicatorTintColor = UIColor.red
        
      
            pageControl.alignment = .center
            pageControl.spacing = 8
            pageControl.dotSize = CGSize(width: 4, height: 4)
        
    }
    
    func cycleViewCustomCellSetup(_ cycleView: ZCycleView, cell: UICollectionViewCell, for index: Int) {
        if let bannerCell = cell as? EOCycleBannerCell {
            
            bannerCell.imageView.sd_setImage(withURL: "http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171114172009707.png", placeholder: UIImage(named: "pic_default_banner"))
            
        }
    }
    
}
