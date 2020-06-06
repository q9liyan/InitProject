//
//  UINavigationController+StatusBar.m
//  JRLive
//
//  Created by xxsskk on 2020/1/16.
//  Copyright © 2020 xxsskk. All rights reserved.
//

#import "UINavigationController+StatusBar.h"

@implementation UINavigationController (StatusBar)
- (UIStatusBarStyle)preferredStatusBarStyle {
    return [[self topViewController] preferredStatusBarStyle];
}
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.visibleViewController;
}
@end
