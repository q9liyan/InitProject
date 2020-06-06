//
//  UIView+Frame.m
//  LLPayView
//
//  Created by lianai on 15/9/6.
//  Copyright (c) 2015年 duxuanhui. All rights reserved.
//

#import "UIView+Frame.h"
#import <objc/runtime.h>

@implementation UIView (Frame)

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;

    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;

    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)h
{
    return self.frame.size.height;
}

- (void)setH:(CGFloat)h
{
    CGRect frame = self.frame;

    frame.size.height = h;
    self.frame = frame;
}

- (CGFloat)w
{
    return self.frame.size.width;
}

- (void)setW:(CGFloat)w
{
    CGRect frame = self.frame;

    frame.size.width = w;
    self.frame = frame;
}

- (void)setCx:(CGFloat)cx
{
    CGPoint center = self.center;

    center.x = cx;
    self.center = center;
}

- (CGFloat)cx
{
    return self.center.x;
}

- (void)setCy:(CGFloat)cy
{
    CGPoint center = self.center;

    center.y = cy;
    self.center = center;
}

- (CGFloat)cy
{
    return self.center.y;
}


@end
