
#import "LBProgressHUD+Extension.h"

@implementation LBProgressHUD (Extension)

#pragma mark 显示一条信息
+ (void)showMessage:(NSString *)message toView:(UIView *)view{
    [self show:message icon:nil view:view];
}

#pragma mark 显示带图片或者不带图片的信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    LBProgressHUD *hud = [LBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 判断是否显示图片
    if (icon == nil) {
        hud.mode = LBProgressHUDModeText;
    }else{
        // 设置图片
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"LBProgressHUD.bundle/%@", icon]];
        img = img == nil ? [UIImage imageNamed:icon] : img;
        hud.customView = [[UIImageView alloc] initWithImage:img];
        // 再设置模式
        hud.mode = LBProgressHUDModeCustomView;
    }
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 指定时间之后再消失
    [hud hide:YES afterDelay:kHudShowTime];
}

#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

#pragma mark 显示警告信息
+ (void)showWarning:(NSString *)Warning toView:(UIView *)view{
    [self show:Warning icon:@"warn" view:view];
}

#pragma mark 显示自定义图片信息
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(UIView *)view{
    [self show:message icon:imageName view:view];
}

#pragma mark 加载中
+ (LBProgressHUD *)showActivityMessage:(NSString*)message view:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    LBProgressHUD *hud = [LBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 细节文字
    //    hud.detailsLabelText = @"请耐心等待";
    // 再设置模式
    hud.mode = LBProgressHUDModeIndeterminate;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (LBProgressHUD *)showProgressBarToView:(UIView *)view withMessage:(NSString *) message{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    LBProgressHUD *hud = [LBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = LBProgressHUDModeDeterminate;
    hud.labelText = message;
    return hud;
}



+ (void)showMessage:(NSString *)message{
    [self showMessage:message toView:nil];
}

+ (void)showSuccess:(NSString *)success{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error{
    [self showError:error toView:nil];
}

+ (void)showWarning:(NSString *)Warning{
    [self showWarning:Warning toView:nil];
}

+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message{
    [self showMessageWithImageName:imageName message:message toView:nil];
}

+ (LBProgressHUD *)showActivityMessage:(NSString*)message{
    return [self showActivityMessage:message view:nil];
}




+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD{
    [self hideHUDForView:nil];
}

#pragma mark - 自定义加载方法

/**
 显示文字和消息

 @param text <#text description#>
 @param icon <#icon description#>
 @param view <#view description#>
 @param seconds <#seconds description#>
 @param complete <#complete description#>
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view seconds:(double) seconds completed:(void(^)(void)) complete{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    LBProgressHUD *hud = [LBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 判断是否显示图片
    if (icon == nil) {
        hud.mode = LBProgressHUDModeText;
    }else{
        // 设置图片
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"LBProgressHUD.bundle/%@", icon]];
        img = img == nil ? [UIImage imageNamed:icon] : img;
        hud.customView = [[UIImageView alloc] initWithImage:img];
        // 再设置模式
        hud.mode = LBProgressHUDModeCustomView;
    }
    

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        unsigned int second =(unsigned int)(seconds*100);
         usleep(10000*second);
        // 100%后移除
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
            complete();
        });
    });
}

/**
 带加载进度的弹框

 @param view <#view description#>
 @param message <#message description#>
 @param timer <#timer description#>
 @param complete <#complete description#>
 */
+ (void)showLoadingProgress:(UIView *) view message:(NSString *) message second:(double) timer completed:(void(^)(void)) complete {
    LBProgressHUD *hud = [LBProgressHUD showProgressBarToView:view withMessage:message];
    
    unsigned int second = 10;
    if (timer > 0) {
        second = (unsigned int)(timer*10);
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        float progress = 0.0f;
        
        while (progress < 1.0f) {
            progress += 0.01f;
            // 主线程刷新进度
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.progress = progress;
            });
            // 进程挂起10毫秒
            usleep(1000*second);
        }
        // 100%后移除
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
            complete();
        });
    });
}


/**
 显示成功

 @param success <#success description#>
 @param view <#view description#>
 @param seconds <#seconds description#>
 @param complete <#complete description#>
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view seconds:(double) seconds completed:(void(^)(void)) complete{
    [self show:success icon:@"success.png" view:view seconds:seconds completed:complete];
}

/**
 显示错误信息

 @param error <#error description#>
 @param view <#view description#>
 @param seconds <#seconds description#>
 @param complete <#complete description#>
 */
+ (void)showError:(NSString *)error toView:(UIView *)view seconds:(double) seconds completed:(void(^)(void)) complete{
    [self show:error icon:@"error.png" view:view seconds:seconds completed:complete];
}


/**
 显示提醒

 @param Warning <#Warning description#>
 @param view <#view description#>
 @param seconds <#seconds description#>
 @param complete <#complete description#>
 */
+ (void)showMessage:(NSString *)message toView:(UIView *)view seconds:(double) seconds completed:(void(^)(void)) complete{
    [self show:message icon:@"warn" view:view seconds:seconds completed:complete];
}
@end
