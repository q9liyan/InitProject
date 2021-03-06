//
//  HomeCommonBannerCell.swift
//  Eduoep
//
//  Created by apple on 2020/6/6.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HomeCommonBannerCell: EOBaseTableViewCell {
    let cycleView = ZCycleView()
    var modelItem: HomeCommonViewModelItem?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
             addSubview(cycleView)
//             cycleView.isInfinite = false
        
    }
    
    
    override func layoutSubviews() {
        
        
        cycleView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func configureModel(modelItem: HomeViewModelItem) {
        guard var commonModel = modelItem as? HomeCommonViewModelItem else {
            log.debug("HomeViewModelItem ->  HomeCommonViewModelItem error")
            return
        }
        DispatchMainThreadSafe {
            if self.cycleView.superview == nil {
                self.addSubview(self.cycleView)
                  }
        }
      
        
        self.modelItem = commonModel
        cycleView.delegate = self
        cycleView.itemSize = CGSize(width: ScreenWidth-20, height: (ScreenWidth-160)*300/750)
        cycleView.setUrlsGroup(commonModel.imagePaths)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
    }
    
    static func reuseIdentifier() -> String {
           return "HomeCommonBannerCell"
       }
    
}

extension HomeCommonBannerCell: ZCycleViewProtocol {
    
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
             let imagePath = modelItem?.imagePaths[index]
             bannerCell.imageView.sd_setImage(withURL: imagePath, placeholder: UIImage(named: "pic_default_banner"))
             
         }
     }
    
}
