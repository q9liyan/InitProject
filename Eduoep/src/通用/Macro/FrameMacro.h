//
//  FrameMacro.h
//  SuanGuo
//
//  Created by lianai on 16/3/3.
//  Copyright © 2016年 lianai. All rights reserved.
//

#ifndef FrameMacro_h
#define FrameMacro_h

#define ScreenFrame         (CGRectMake(0, 0, ScreenWidth, ScreenHeight))
/**
 *  屏幕宽
 */
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
/**
 * 颜色color
 */

#define RGBCOLOR(r,g,b)        [UIColor colorWithRed:(r)/255.0 \
green:(g)/255.0 \
blue:(b)/255.0 \
alpha:1.0]

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define kNavBarHeight 44.0

#define kTopHeight (kStatusBarHeight + kNavBarHeight)

/**
 *  屏幕高  
 */
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

/// 第一个参数是当下的控制器适配iOS11 一下的，第二个参数表示scrollview或子类
//#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}
#define SafeAreaTopHeight (@available(iOS 11.0, *)?([[[[UIApplication sharedApplication] delegate]window] safeAreaInsets].top <= 20 ? 64 : 88):64)
#define SafeAreaTop (@available(iOS 11.0, *)?[[[[UIApplication sharedApplication] delegate]window] safeAreaInsets].top : 0)

#define SafeAreaBottomHeight (@available(iOS 11.0, *)?[[[[UIApplication sharedApplication] delegate]window] safeAreaInsets].bottom:0)

#pragma mark - TabBar

#define TabBarDefaultHeight     49
#define LiveTabBarItemHeight    66

#pragma mark - 消息cell的高度计算
#define ContentLabelWidth       (ScreenWidth - 112 - 18 - 12 - 6)
#define ContentLabelMinHeigh    20 // 后来把背景图调了,加了vip背景图,需要加4
#define ContentLabelMinWidth    20
#define frameRate (667.0 / ScreenHeight)
#define frameRateWidth (375.0 / ScreenWidth)
#define kSizeRate (ScreenWidth/ScreenHeight)
#define wRate     (ScreenHeight == 812.0 ? (ScreenHeight / 812.0):(ScreenHeight / 667.0))
#define hRate     (ScreenWidth / 375.0)

#define kW(R)     R*(ScreenWidth / 375.0)
#define kH(R)     ScreenHeight == 667.0 ? R : R*(ScreenHeight/667.0)
#define font(R)   ScreenHeight == 736.0 || 812 ? R :   (R)*(ScreenHeight)/667.0
#define kFONT(fontSize)                  [UIFont systemFontOfSize:font(fontSize)]

#define kCGRectMake(x, y, w, h) CGRectMake(x, y, w, h)

#endif /* FrameMacro_h */
