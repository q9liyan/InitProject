//
//  UIView+SGViewCG.m
//  SuanGuo
//
//  Created by 周宇晗 on 12/07/2017.
//  Copyright © 2017 lianai. All rights reserved.
//

#import "UIView+SGViewCG.h"

@implementation UIView (SGViewCG)

- (void)setCorner:(CGFloat)corner {
    
    self.layer.cornerRadius = corner;
    self.layer.masksToBounds = YES;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    
    if (borderWidth < 0) return;
    
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    
    self.layer.borderColor = borderColor.CGColor;
}

-(NSLayoutConstraint *)p_changeMultiplierOfConstraint:(NSLayoutConstraint *)constraint multiplier:(CGFloat)multiplier {
    
    [NSLayoutConstraint deactivateConstraints:@[constraint]];
    NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:constraint.firstItem attribute:constraint.firstAttribute relatedBy:constraint.relation toItem:constraint.secondItem attribute:constraint.secondAttribute multiplier:multiplier constant:constraint.constant];
    newConstraint.priority = constraint.priority;
    newConstraint.shouldBeArchived = constraint.shouldBeArchived;
    newConstraint.identifier = constraint.identifier;
    [NSLayoutConstraint activateConstraints:@[newConstraint]];
    return newConstraint;
}

@end
