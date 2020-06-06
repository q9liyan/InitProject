//
//  UIView+AddVirtualLine.m
//  JRLive
//
//  Created by xxsskk on 2020/2/21.
//  Copyright © 2020 xxsskk. All rights reserved.
//

#import "UIView+AddVirtualLine.h"
static char addVirtualLineKey;

@implementation UIView (AddVirtualLine)

@dynamic virtualLine;

- (void)setVirtualLine:(CAShapeLayer *)virtualLine{
    objc_setAssociatedObject ( self, @selector (virtualLine), virtualLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

- (CAShapeLayer *)virtualLine{
    return objc_getAssociatedObject(self, @selector (virtualLine));
}

- (void)addVirtualLine{
    self.layer.borderColor = Color(@"#clear").CGColor;
    self.layer.borderWidth = 0.f;
    self.layer.cornerRadius = 0.f;
    
    if (!self.virtualLine) {
        CGRect bounds = CGRectMake(0, 0, 345 - 58, self.h);
        UIBezierPath *maskPath = [[UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)] bezierPathByReversingPath];
        CAShapeLayer *border = [CAShapeLayer layer];
        // 线条颜色
        border.strokeColor = Color(@"#CCCCCC").CGColor;
        border.masksToBounds = YES;

        border.fillColor = nil;
        border.path = maskPath.CGPath;
        border.frame = bounds;

        border.lineWidth = 1;
        border.lineCap = @"square";
        // 第一个是 线条长度 第二个是间距 nil时为实线
        border.lineDashPattern = @[@6, @4];
        [self.layer addSublayer:border];
        self.virtualLine = border;
    }
    [self.layer addSublayer:self.virtualLine];
}
- (void)addRealLine{
    if (self.virtualLine) {
        [self.virtualLine removeFromSuperlayer];
    }
    self.layer.borderColor = Color(@"#9D1DFE").CGColor;
    self.layer.borderWidth = 1.f;
    self.layer.cornerRadius = 10.f;
}
@end
