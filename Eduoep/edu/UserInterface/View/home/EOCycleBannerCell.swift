//
//  EOCycleBannerCell.swift
//  Eduoep
//
//  Created by apple on 2020/6/4.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class EOCycleBannerCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = Img("pic_default_banner")
        
        addSubview(imageView)
    }
    
    
    
    override func layoutSubviews() {
        imageView.snp.makeConstraints { (make) in
            make.bottom.left.top.equalToSuperview()
            make.right.equalTo(self.snp.right).offset(-10)
            
        }
        
        imageView.setCornerRadius(radius: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
