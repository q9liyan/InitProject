//
//  UIViewController+Toast.m
//  SuanGuo
//
//  Created by lianai on 16/3/2.
//  Copyright © 2016年 lianai. All rights reserved.
//

#import "UIViewController+Toast.h"
#import "SGAppUtils.h"

@implementation UIViewController (Toast)

-(void)showTapMessage:(NSString *)message
{
    if (message.length>0) {
        [SGAppUtils showManualHideMessageTap:message onView:[UIApplication sharedApplication].keyWindow];
    }
}

- (void)showMessage:(NSString *)message
{
    if (message.length>0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SGAppUtils showAutoHideMessage:message onView:[UIApplication sharedApplication].keyWindow];
        });
    }
}

- (void)showMessage:(NSString *)message whileExecutingBlock:(dispatch_block_t)block
{
    [SGAppUtils showMessage:message onView:[UIApplication sharedApplication].keyWindow whileExecutingBlock:block];
}

- (void)showOnlyMessage:(NSString *)message completionBlock:(dispatch_block_t)block
{
    

    [SGAppUtils showOnlyMessage:message onView:[UIApplication sharedApplication].keyWindow completionBlock:block];
}
- (void)showMessageManualHide:(NSString *)message {
//    [SGAppUtils showManualHideMessage:message onView:[UIApplication sharedApplication].keyWindow];
    [self showManualHideOfCustomLoading];
}
- (void)showManualHideOfCustomLoading{
    // 获取keyWindow
    [SGAppUtils showCustomLoading];
}

- (void)hideHUD
{
    [SGAppUtils hideHUD];
    [SGAppUtils hideCustomLoading];
}
- (void)hideManualHideOfCustomLoading{
    [SGAppUtils hideCustomLoading];
}
@end
