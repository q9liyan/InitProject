//
//  UIView+Frame.h
//  LLPayView
//
//  Created by lianai on 15/9/6.
//  Copyright (c) 2015年 duxuanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SGFrame)

@property(nonatomic, assign) CGFloat    x;
@property(nonatomic, assign) CGFloat    xx;
@property(nonatomic, assign) CGFloat    y;
@property(nonatomic, assign) CGFloat    w;
@property(nonatomic, assign) CGFloat    h;
@property(nonatomic, assign) CGFloat    cx;
@property(nonatomic, assign) CGFloat    cy;

/**
 *  dw,dh是设计稿上标明的宽度和高度，适用于需要根据不同机型来改变控件尺寸的场景
 */
//@property(nonatomic, assign) CGFloat    dw;
//@property(nonatomic, assign) CGFloat    dh;

@property CGSize size;

/**
 *  左下角
 */
@property (readonly) CGPoint bottomLeft;

/**
 *  右下角
 */
@property (readonly) CGPoint bottomRight;

/**
 *  右上角
 */
@property (readonly) CGPoint topRight;

/**
 *  左上角，原点
 */
@property CGPoint origin;

@property CGFloat   top;
@property CGFloat   left;
@property CGFloat   bottom;
@property CGFloat   right;
- (BOOL)isShowingOnKeyWindow;
@end
