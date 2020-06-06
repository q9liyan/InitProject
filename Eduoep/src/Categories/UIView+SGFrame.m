//
//  UIView+Frame.m
//  LLPayView
//
//  Created by lianai on 15/9/6.
//  Copyright (c) 2015年 duxuanhui. All rights reserved.
//

#import "UIView+SGFrame.h"
#import <objc/runtime.h>

@implementation UIView (SGFrame)

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

- (CGFloat)xx
{
    return self.frame.origin.x+self.frame.size.width;
}

- (void)setXx:(CGFloat)xx
{
    CGRect frame = self.frame;
    
    frame.origin.x = xx - self.frame.size.width;
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

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)aPoint
{
    CGRect newframe = self.frame;

    newframe.origin = aPoint;
    self.frame = newframe;
}

// Retrieve and set the size
- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)aSize
{
    CGRect newframe = self.frame;

    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint)bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;

    return CGPointMake(x, y);
}

- (CGPoint)bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;

    return CGPointMake(x, y);
}

- (CGPoint)topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;

    return CGPointMake(x, y);
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop
{
    CGRect newframe = self.frame;

    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)newleft
{
    CGRect newframe = self.frame;

    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)newbottom
{
    CGRect newframe = self.frame;

    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect  newframe = self.frame;

    newframe.origin.x += delta;
    self.frame = newframe;
}

- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect  newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect  winBounds = keyWindow.bounds;

    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);

    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

@end
