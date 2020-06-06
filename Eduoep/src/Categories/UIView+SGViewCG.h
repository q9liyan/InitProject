//
//  UIView+SGViewCG.h
//  SuanGuo
//
//  Created by 周宇晗 on 12/07/2017.
//  Copyright © 2017 lianai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SGViewCG)
@property (nonatomic, assign) IBInspectable CGFloat corner;
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;

@property (nonatomic, strong)IBInspectable UIColor *borderColor;

-(NSLayoutConstraint *)p_changeMultiplierOfConstraint:(NSLayoutConstraint *)constraint multiplier:(CGFloat)multiplier;

@end

