//
//  UIDevice+Hardware.m
//
//  Created by 许 强 on 13-1-10.
//  Copyright (c) 2013年 win32. All rights reserved.
//

#import "UIDevice+CCHardware.h"
#import "FrameMacro.h"
/**
 *  屏幕高
 */
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
static BOOL isRetinaScreen = NO;
static BOOL didRetinaCheck = NO;

static CCDeviceType deviceType;

@implementation UIDevice(CCHardware_MMC)
+ (CGFloat)ofSafeAreaTopHeight{
    return SafeAreaTopHeight;
}
+ (CGFloat)ofSafeAreaTop{
    return 20;
}
+ (CGFloat)ofSafeAreaBottomHeight{
    return SafeAreaBottomHeight;
}
+ (CGFloat)FitWidth:(CGFloat)w{
    return kW(w);
}
+ (CGFloat)FitHeight:(CGFloat)h{
    return kH(h);
}

+ (CCDeviceType)currentDeviceType {

    if ([UIDevice isSimulator]) {
        //模拟器
        if((ScreenHeight == 568)) {   //iphone5，5s,se
            deviceType = ccIPhone5;
        } else if(ScreenHeight == 480) {//iphone4,4s
            deviceType = ccIPhone4;
        }
        else if(ScreenHeight == 667) {//iphone6,7,8,iphone6s,7s
            deviceType = ccIPhone6;
        }else if(ScreenHeight == 736) {//iphone 6,7,8 plus
            deviceType = ccIPhone6Plus;
        }else if(ScreenHeight == 812 || ScreenHeight == 896) {//iphone X
            deviceType = ccIPhoneX;
        }else if(ScreenHeight == 1024 || ScreenHeight == 1112 || ScreenHeight == 1336) {//ipad 9.7,10.5,12.9英寸
            deviceType = ccIPad;
        }
    }else{
        //真实设备
        UIUserInterfaceIdiom useInterfaceIdiom =[[UIDevice currentDevice] userInterfaceIdiom];
        NSString *platform = [UIDevice platformString];
        if (useInterfaceIdiom == UIUserInterfaceIdiomPhone && ([platform rangeOfString:@"iPhone"].location != NSNotFound || [platform rangeOfString:@"iPod"].location != NSNotFound)) {
            if((ScreenHeight == 568)) {   //iphone5
                deviceType = ccIPhone5;
            } else if(ScreenHeight == 480) {//iphone4
                deviceType = ccIPhone4;
            }
            else if(ScreenHeight == 667) {//iphone6
                deviceType = ccIPhone6;
            }else if(ScreenHeight == 736) {//iphone 6 plus
                deviceType = ccIPhone6Plus;
            }else if(ScreenHeight == 812 || ScreenHeight == 896) {//iphone X
                deviceType = ccIPhoneX;
            }
            
        } else if([platform rangeOfString:@"iPad"].location != NSNotFound){
            deviceType = ccIPad;
        }
    }
    
    
 
    return deviceType;
}

+ (BOOL)isSimulator {
    NSString *platform = [UIDevice platform];
    if ([platform rangeOfString:@"86"].location != NSNotFound) {
        return YES;
    }
    return NO;
}

+ (BOOL)hasCamera {
    BOOL isRearCameraAvaliabel = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    BOOL isFrontCameraAvaliabel = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    
    return isRearCameraAvaliabel | isFrontCameraAvaliabel;
}

+ (NSString *)platform{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString*)platformString
{
    NSString *platform = [UIDevice platform];
    
    if ([platform isEqualToString:@"iPhone4,1"]) {
        platform = @"iPhone 4S";
    } else if ([platform isEqualToString:@"iPhone5,1"]) {
        platform = @"iPhone 5";
    } else if ([platform isEqualToString:@"iPhone5,2"]) {
        platform = @"iPhone 5S";
    } else if ([platform isEqualToString:@"iPhone3,1"]) {
        platform = @"iPhone 4";
    }  else if ([platform isEqualToString:@"iPod4,1"]) {
        platform = @"iPod touch 4";
    } else if ([platform isEqualToString:@"iPod5,1"]) {
        platform = @"iPod touch 5";
    } else if ([platform isEqualToString:@"iPad4,2"]) {
        platform = @"iPad 4 3G";
    } else if ([platform isEqualToString:@"iPad4,1"]) {
        platform = @"iPad 4 WiFi";
    } else if ([platform isEqualToString:@"iPad3,2"]) {
        platform = @"iPad 3 3G";
    } else if ([platform isEqualToString:@"iPad3,1"]) {
        platform = @"iPad 3 WiFi";
    } else if ([platform isEqualToString:@"iPad2,2"]) {
        platform = @"iPad 2 3G";
    } else if ([platform isEqualToString:@"iPad2,1"]) {
        platform = @"iPad 2 WiFi";
    } else if ([platform isEqualToString:@"iPad1,1"]) {
        platform = @"iPad 1 WiFi";
    } else if ([platform isEqualToString:@"iPhone1,1"]) {
        platform = @"iPhone";
    } else if ([platform isEqualToString:@"iPhone1,2"]) {
        platform = @"iPhone 3G";
    } else if ([platform isEqualToString:@"iPhone2,1"]) {
        platform = @"iPhone 3GS";
    }else if ([platform isEqualToString:@"iPhone7,1"]) {
        platform = @"iPhone6 Plus";
    }else if ([platform isEqualToString:@"iPhone7,2"]) {
        platform = @"iPhone6";
    }
    return platform;
}

/** 返回精简版系统版本如5,6,7 */
+ (CGFloat)iOSVersion {
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version;
}

/** 返回完整系统版本如5.1.2 */
+ (NSString *)iOSVersionString {
    NSString *version = [[UIDevice currentDevice] systemVersion];
    return version;
}

+ (BOOL)retinaScreen
{
    if (!didRetinaCheck) {
        isRetinaScreen = ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
                          ([UIScreen mainScreen].scale == 2.0));
        didRetinaCheck = YES;
    }
    return isRetinaScreen;
}
//可以使用一下语句判断是否是刘海手机：
+ (BOOL)isPhoneX {
   BOOL iPhoneX = NO;
     if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
           return iPhoneX;
       }
       if (@available(iOS 11.0, *)) {
           UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
           if (mainWindow.safeAreaInsets.bottom > 0.0) {
               iPhoneX = YES;
           }
       }
    return iPhoneX;
}
@end
