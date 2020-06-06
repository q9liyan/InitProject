//
//  UIDevice+Hardware.h
//  获取设备相关的参数,如设备的类型,是否模拟器等
//
//  Created by 许 强 on 13-1-10.
//  Copyright (c) 2013年 win32. All rights reserved.
//

#include <sys/types.h>
#include <sys/sysctl.h>

#import <UIKit/UIKit.h>

#define IPAD ([UIDevice currentDeviceType] == ccIPad)
#define IPHONE4 ([UIDevice currentDeviceType] == ccIPhone4)
#define IPHONE5 ([UIDevice currentDeviceType] == ccIPhone5)
#define IPHONE6 ([UIDevice currentDeviceType] == ccIPhone6)
#define IPHONE6Plus ([UIDevice currentDeviceType] == ccIPhone6Plus)
#define IPHONEX ([UIDevice currentDeviceType] == ccIPhoneX)
/**
 精确范围
 */
#define IOS9 ([UIDevice iOSVersion] >= 9.0) && ([UIDevice iOSVersion] < 10.0)
#define IOS10 ([UIDevice iOSVersion] >= 10.0) && ([UIDevice iOSVersion] < 11.0)

#define IOS11 ([UIDevice iOSVersion] >= 11.0) && ([UIDevice iOSVersion] < 12.0)
#define IOS12 ([UIDevice iOSVersion] >= 12.0) && ([UIDevice iOSVersion] < 13.0)
#define IOS13 ([UIDevice iOSVersion] >= 13.0) 
/**
 大概范围
 */

#define IOS9_ ([UIDevice iOSVersion] >= 9.0)
#define IOS10_ ([UIDevice iOSVersion] >= 10.0)
#define IOS11_ ([UIDevice iOSVersion] >= 11.0)
typedef enum  {
    CCDeviceTypeNone = 0,
    ccIPhone4 = 1,
    ccIPhone5 = 2,//iphone c, iphone se
    ccIPhone6 = 3, //iPhone7 iPhone8
    ccIPhone6Plus = 4,// iPhone 7 Plus, iPhone 8 Plus
    ccIPhoneX = 5,//iPhone X,iPhone Xs,iPhone Xr,iPhone Xs max
    ccIPad = 6
} CCDeviceType;

@interface UIDevice(CCHardware_MMC)
+ (CGFloat)ofSafeAreaTopHeight;
+ (CGFloat)ofSafeAreaBottomHeight;

+ (CGFloat)ofSafeAreaTop;

+ (CGFloat)FitWidth:(CGFloat)w;
+ (CGFloat)FitHeight:(CGFloat)h;

/** 获取当前设备种类 */
+ (CCDeviceType)currentDeviceType;

+ (BOOL)isSimulator;

+ (BOOL)hasCamera;

+ (NSString*)platformString;

+ (NSString*)platform;

/** 返回精简版系统版本如5,6,7 */
+ (CGFloat)iOSVersion;

/** 返回完整系统版本如5.1.2 */
+ (NSString *)iOSVersionString;

+ (BOOL)retinaScreen;

//是否刘海屏
+ (BOOL)isPhoneX;
@end
