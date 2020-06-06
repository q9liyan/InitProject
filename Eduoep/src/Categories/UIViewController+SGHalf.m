//
//  UIViewController+SGHalf.m
//  SuanGuo
//
//  Created by xxsskk on 2019/10/11.
//  Copyright © 2019 lianai. All rights reserved.
//

#import "UIViewController+SGHalf.h"
#import <objc/runtime.h>

static int kIsHalf;

@implementation UIViewController (SGHalf)

-(BOOL)isHalf{
    return objc_getAssociatedObject(self, &kIsHalf);
}

-(void)setIsHalf:(BOOL)isHalf{
    objc_setAssociatedObject(self, &kIsHalf, @(isHalf), OBJC_ASSOCIATION_ASSIGN);
}

@end
