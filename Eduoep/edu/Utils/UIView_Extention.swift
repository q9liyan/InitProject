//
//  UIView_Extention.swift
//  Eduoep
//
//  Created by apple on 2020/6/3.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// 设置UI 文本、字体大小、字体颜色
    /// - Parameters:   Cupcake
     @discardableResult func fontWeight(_ size: CGFloat,weight: UIFont.Weight = .regular) -> Self {
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
          return self
    }
    
 
    
}


extension UIButton {

    /// 设置UI 文本、字体大小、字体颜色
     /// - Parameters:   Cupcake
     @discardableResult func fontWeight(_ size: CGFloat,weight: UIFont.Weight = .regular) -> Self {
           self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: weight)
           return self
     }
    
    func setGradient(color_vaule1: UInt64,color_vaule12: UInt64,state: UIControl.State,height: CGFloat? = 44) {
        let color1 = UIColor.rgbHex(color_vaule1)
        let color2 = UIColor.rgbHex(color_vaule12)
        
        setBackgroundImage(UIImage.gradientBgColor(color1: color1, color2: color2, height: height), for: state)
    }
    
}

extension UIView {
    
    /// 设置顶部圆角
    ///
    /// - Parameter radius: 圆角半径
    func setCornerOnTop(radius:CGFloat) {
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue), cornerRadii: CGSize.init(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    /// 设置圆角
    ///
    /// - Parameter radius: 圆角半径
    func setCornerRadius(radius:CGFloat) {
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue | UIRectCorner.bottomLeft.rawValue | UIRectCorner.bottomRight.rawValue), cornerRadii: CGSize.init(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}

extension UIImage {
    class func gradientDefaultColor(height: CGFloat? = 44) -> UIImage {
        return self.gradientBgColor(color1: UIColor.rgbHex(0x84DBFF), color2: UIColor.rgbHex(0x84DBFF), height: height)
    }
    
    class func gradientBgColor(color1:UIColor!,color2:UIColor!,height: CGFloat? = 44) -> UIImage{
        let v = UIView.init(frame: CGRect.init(x: 0,y: 0,width: ScreenWidth - 64,height: height!))
           
           // 背景渐变
           let gradient = CAGradientLayer.init()
           gradient.frame = CGRect.init(x: 0,y: 0,width: ScreenWidth - 64,height: height!)
           //设置渐变颜色方向
           gradient.startPoint = CGPoint.init(x: 0,y: 0.5)
           gradient.endPoint = CGPoint.init(x: 1,y: 0.5)

           //设定颜色组
           gradient.colors = [color1.cgColor,color2.cgColor]
           
           gradient.locations = [NSNumber.init(value: 0.0),NSNumber.init(value: 1.0)];
           
           v.layer.insertSublayer(gradient,at: 0)
           

           
           UIGraphicsBeginImageContext(v.bounds.size)
           v.layer.render(in: UIGraphicsGetCurrentContext()!)
           let imgae = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return imgae!
       }
}

extension YYLabel {
    // 设置下划线
    func setUnderline(attributedString: String, rang: NSRange, style: YYTextLineStyle? = .single) {
        let deco = YYTextDecoration(style: style!)
        let atetx = NSMutableAttributedString(string: attributedString)
        atetx.yy_setTextUnderline(deco, range: rang)
    }
    
    
}
