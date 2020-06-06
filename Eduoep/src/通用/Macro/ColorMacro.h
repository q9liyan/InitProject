//
//  ColorMacro.h
//  SuanGuo
//
//  Created by lianai on 16/3/1.
//  Copyright © 2016年 lianai. All rights reserved.
//
#import "SGAppUtils.h"
#import "AppMacro.h"


#ifndef ColorMacro_h
#define ColorMacro_h

#define _ColorFromHex(hex) [SGAppUtils colorWithHexString: hex]

#define Color_AppNavigationBarColor             [UIColor colorWithRed:1.00 green:0.25 blue:0.58 alpha:1.00]
#define Color_AppNavigationBoottomColor         Color_RGB(245, 245, 245)

#define Color_LiveRoom_AppNavigationBarColor    _ColorFromHex(@ "#f4f4f4")

#define Color_ButtonTextNormalColor_grey        _ColorFromHex(@ "#999999")
#define Color_ButtonTextHightColot_white        [UIColor whiteColor]

#define Color_LabelTextTitleColor_black         _ColorFromHex(@ "#333333")
#define Color_LabelTextSubTitleColor_warmGrey   _ColorFromHex(@ "#999999")

#define Color_SplitLineColor                    _ColorFromHex(@ "#EDEDED")
#define Color_CellColor_white                   [UIColor whiteColor]

#define Color_TextColor_Gold                    _ColorFromHex(@ "#ffbe00")
#define Color_TextColor_Green                   _ColorFromHex(@ "#0eaa22")

// 随机色
#define  Color_Random                           [UIColor colorWithRed: (arc4random_uniform(256)) / 255.0 green: (arc4random_uniform(256)) / 255.0 blue: (arc4random_uniform(256)) / 255.0 alpha: 1.0]
// RGB颜色
#define Color_RGB(r, g, b)  (SystemVersion < 10)?([UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha: 1.0]):([UIColor colorWithDisplayP3Red:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0])

//整体风格颜色，主题色等
#define Color_MainColor                        _ColorFromHex(@"#ff4a9f")

#endif /* ColorMacro_h */
