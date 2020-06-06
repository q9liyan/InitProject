//
//  UIViewController+Toast.h
//  SuanGuo
//
//  Created by lianai on 16/3/2.
//  Copyright © 2016年 lianai. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIViewController (Toast)

-(void)showTapMessage:(NSString *)message;

- (void)showMessage:(NSString *)message;

- (void)showMessage:(NSString *)message whileExecutingBlock:(dispatch_block_t)block;
- (void)showOnlyMessage:(NSString *)message completionBlock:(dispatch_block_t)block;
- (void)showMessageManualHide:(NSString *)message;

- (void)hideHUD;

//加和移除
- (void)showManualHideOfCustomLoading;
- (void)hideManualHideOfCustomLoading;
@end
