
/**

 **/

#import "LBProgressHUD.h"

// 统一的显示时长
#define kHudShowTime 1.5

@interface LBProgressHUD (Extension)

#pragma mark 在指定的view上显示hud
+ (void)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showWarning:(NSString *)Warning toView:(UIView *)view;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(UIView *)view;
+ (LBProgressHUD *)showActivityMessage:(NSString*)message view:(UIView *)view;
+ (LBProgressHUD *)showProgressBarToView:(UIView *)view;

#pragma mark 在window上显示hud
+ (void)showMessage:(NSString *)message;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showWarning:(NSString *)Warning;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message;
+ (LBProgressHUD *)showActivityMessage:(NSString*)message;


#pragma mark 移除hud
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

#pragma mark 带时间和结束回调的
+ (void)showMessage:(NSString *)message toView:(UIView *)view seconds:(double) seconds completed:(void(^)(void)) complete;
+ (void)showError:(NSString *)error toView:(UIView *)view seconds:(double) seconds completed:(void(^)(void)) complete;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view seconds:(double) seconds completed:(void(^)(void)) complete;
+ (void)showLoadingProgress:(UIView *) view message:(NSString *) message second:(double) timer completed:(void(^)(void)) complete;
@end
