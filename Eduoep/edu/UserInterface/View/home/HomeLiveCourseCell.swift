//
//  HomeTableViewCell.swift
//  Eduoep
//
//  Created by apple on 2020/6/6.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HomeLiveCourseCell: EOBaseTableViewCell {
    
    let cycleView = ZCycleView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cycleView)
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
    
    static func reuseIdentifier() -> String {
        return "HomeLiveCourseCell"
    }
}

extension HomeLiveCourseCell: ZCycleViewProtocol {
    
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
