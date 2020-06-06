//
//  ChoiceTableViewCell.swift
//  Eduoep
//
//  Created by apple on 2020/6/5.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class EOChoiceTableViewCell: UITableViewCell {
    let titleLabel: UILabel
    let checkmarkImageView: UIImageView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.titleLabel = UILabel()
        self.checkmarkImageView = UIImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkmarkImageView)
        
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    override func layoutSubviews() {
        self.titleLabel.snp.makeConstraints { (make) in
            
        }
        
        self.checkmarkImageView.snp.makeConstraints { (make) in
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
//    override func prepareForReuse() {
//          self.checkmarkImageView.image = UIImage(named: "ic_contact_unselected")
//          self.subtitleLabel.removeFromSuperview()
//     }
}
