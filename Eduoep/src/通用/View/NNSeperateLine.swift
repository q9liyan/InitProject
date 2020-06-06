//
//  NNSeperateLine.swift
//  JRLive
//
//  Created by xxsskk on 2019/11/28.
//  Copyright © 2019 xxsskk. All rights reserved.
//

import UIKit

class NNSeperateLine: UIView {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.bg("#EEEEEE")
    }
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        self.bg("#EEEEEE")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bg("#EEEEEE")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
