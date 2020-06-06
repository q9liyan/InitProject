//
//  EOCollectionTagHeaderView.swift
//  Eduoep
//
//  Created by apple on 2020/6/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class EOTagHeaderCell: UICollectionViewCell {

   var titleLabel = UILabel()
    static let reuseIdentifier: String = "EOTagHeaderCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.black
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp_leftMargin).offset(8)
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
