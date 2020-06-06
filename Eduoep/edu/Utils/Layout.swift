//
//  Layout.swift
//  Eduoep
//
//  Created by apple on 2020/6/4.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

///  布局样式
enum LayoutFont {
    case dynamic_11
    case dynamic_13
    case dynamic_14
    case dynamic_20
}

enum LayoutColor {
    case gray99
    case whiteFC
    case blue84
}


class Layout {
    class func getRegularFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    class func getFont(font: LayoutFont,weight: UIFont.Weight? = .regular) -> UIFont {
        switch font {
        case .dynamic_11:
            return UIFont.systemFont(ofSize: 11, weight: weight!)
        case .dynamic_13:
            return UIFont.systemFont(ofSize: 12, weight: weight!)
        case .dynamic_14:
            return UIFont.systemFont(ofSize: 13, weight: weight!)
        case .dynamic_20:
            return UIFont.systemFont(ofSize: 14, weight: weight!)
        default:
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    func getColor(color: LayoutColor) -> UIColor {
        switch color {
        case .gray99:
            return UIColor.rgbHex(0x999999)
        case .whiteFC:
            return UIColor.rgbHex(0xFCFFFF)
        case .blue84:
            return UIColor.rgbHex(0x84DBFF)
        default:
            return UIColor.rgbHex(0xFFFFFF)
        }
    }
}

extension UIColor {
    /// 样式  0x5B5B5B
    ///
    /// - Parameters:
    ///   - color_vaule: 传入0x5B5B5B格式的色值
    ///   - alpha: 传入透明度
    /// - Returns: 颜色
    class func rgbHex(_ color_vaule : UInt64 , alpha : CGFloat = 1) -> UIColor {
        let redValue = CGFloat((color_vaule & 0xFF0000) >> 16)/255.0
        let greenValue = CGFloat((color_vaule & 0xFF00) >> 8)/255.0
        let blueValue = CGFloat(color_vaule & 0xFF)/255.0
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
    }
}

