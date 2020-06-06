//
//  UIView+MQView.h
//  FeiSound
//
//  Created by 周宇晗 on 20/11/2017.
//  Copyright © 2017 xxsskk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MQView)


@property (nonatomic, assign)IBInspectable CGFloat borderWidth;

@property (nonatomic, strong)IBInspectable UIColor *borderColor;

@property (nonatomic, assign) IBInspectable CGFloat corner;

@property (nonatomic, assign) IBInspectable CGFloat cornerTopLR;
@property (nonatomic, assign) IBInspectable CGFloat cornerBottomLR;
@property (nonatomic, assign) IBInspectable CGFloat cornerTopLBottomL;
@property (nonatomic, assign) IBInspectable CGFloat cornerTopRBottomR;

//画虚线
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

//view转图片
- (UIImage *)makeImage;

@end
