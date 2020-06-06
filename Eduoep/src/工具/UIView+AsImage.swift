//
//  UIView+AsImage.swift
//  JRLive
//
//  Created by xxsskk on 2020/2/22.
//  Copyright © 2020 xxsskk. All rights reserved.
//

import UIKit
 
extension UIView {
    //将当前视图转为UIImage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
