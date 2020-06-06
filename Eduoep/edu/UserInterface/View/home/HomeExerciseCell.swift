//
//  HomeExerciseCell.swift
//  Eduoep
//
//  Created by apple on 2020/6/6.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HomeExerciseCell: EOBaseTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func reuseIdentifier() -> String {
        return "HomeExerciseCell"
    }
}
