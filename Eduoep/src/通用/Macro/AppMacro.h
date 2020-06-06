//
//  AppMacro.h
//  SuanGuo
//
//  Created by lianai on 16/3/1.
//  Copyright © 2016年 lianai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCKeyboardManager.h"
#import "UIViewController+Toast.h"
#import "SDWebImageCompat.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Slicing.h"
#import "UIView+SGFrame.h"
#import "UIView+MQView.h"
#import "NerdyUI.h"
//#import "TextFontMacro.h"
#import "ColorMacro.h"

#import "SGGlobalVar.h"

#import "YYText.h"
#import "NotificationMacro.h"

#import "FrameMacro.h"


#ifndef AppMacro_h
#define AppMacro_h

//#define isMaJiaVersion         0

//#define isQiyeVersion         0

//#define isBeta         0

/**
 *  当前系统版本
 */
#define SystemVersion   [[[UIDevice currentDevice] systemVersion] floatValue]

#define SuanGuoVersion  [[[NSBundle mainBundle] infoDictionary] objectForKey: @ "CFBundleShortVersionString"]

// 当前版本的key
#define CURRENT_VERSION @"CURRENT_VERSION"

/**
 *  Debug
 */
#ifdef  DEBUG
#define DebugLog(format, ...) NSLog(format, ## __VA_ARGS__)
#define DebugAssert(e)        assert(e)
#define SGLogFunc NSLog(@ "%s", __func__)

#else
#define DebugLog(format, ...)
#define SGLogFunc
#define DebugAssert(e)
#endif

#define LogFunctionName()           DebugLog(@ "<%@> %s Thread:%@", [[NSString stringWithCString: __FILE__ encoding: NSUTF8StringEncoding] lastPathComponent], __FUNCTION__,[NSThread currentThread])

#pragma mark - 加密

#define SuanGuo3DesKey @ "WGGXhzydkj1SuanGuo"

//微信，qq，新浪的第三方登录的appkey和appsecret
#define QQSpace_key         @ "frqWdcid1mNVCNvn"
#define QQSpace_Appid       @ "101875538"
#define KQQUniversalLinks   @ "https://www.shuyuapp.com/qq_conn/101875538"

#define KWeiXinAppKey       @ "wx5a58939bc42e7967"
#define KWXUniversalLinks   @ "https://search.developer.apple.com/appsearch-validation-tool/"
#define kWeiXinSecret       @ "71086f37b4a21c5112282630b705bdd3"
#define umengAppKey         @"5e970ada978eea0718fb78a9"
//外部调用跳转回来
#define kReturnUrl          @ "nuannuanlive://platformapi/startapp?type=1"

// 微信登录状态用于校验
#define kWeiXinState        @ "JRZhiBo"

#define WXTXAppId     @ "wx72f7d35891f70172"
/** 微信跳转：第三方程序本身用来标识其请求的唯一性，最后跳转回第三方程序时，由微信终端回传。*/
#define APPIdentifier      @ "SUANGUOZHIBO"

// 文件保存路径
#pragma mark - IAP内购失败后存储apple发送过来的receipt路径
#define AppStoreInfoLocalFilePath   [NSString stringWithFormat: @"%@/%@/", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], @"EACEF35FE363A75A"]

#define sgDataBaseQueue [NNAppMSGM instance].databaseQueue

#define SGWeakself __weak typeof(self) weakself = self;
#define WS __weak typeof(self) ws = self;
#define SGStrongself __strong typeof(weakself)strongself = weakself;

#define SGWeakseeeelf __weak typeof(self) weakseeeelf = self;
#define SGStrongseeeelf __strong typeof(weakseeeelf)strongseeeelf = weakseeeelf;

#define KeyboardManagerInstance [SCKeyboardManager shared]

#pragma mark 工具宏
#define FBridge(x, y, z)        ((__bridge z)(y)x)
#define FType(x, y)        ((x)y)
#define IsKindOfClass(x, y)         [x isKindOfClass:[y class]]

//中体字
#define MediumFont(x) [UIFont fontWithName:@"PingFangSC-Medium" size: (x)]

/**
 *  随机数
 */
#define Random(x) (arc4random() % (x+1))

#define RandomNO0(x) (arc4random() % (x) +1)

typedef id (^WeakReference)(void);
WeakReference boxAsWeakReference(id object);
id unboxWeakReference(WeakReference ref);
#define NSUserW(x,y) ({[[NSUserDefaults standardUserDefaults] setObject:x forKey:y];[[NSUserDefaults standardUserDefaults] synchronize];})
#define NSUserR(x) [[NSUserDefaults standardUserDefaults] objectForKey:x]
// 实例宏
#define NSNC [NSNotificationCenter defaultCenter]
// 构造函数
#define SCConcat_(a, b) a ## b
#define SCConcat(a, b) SCConcat_(a, b)
#define SCConstructor static __attribute__((constructor)) void SCConcat(SCConstructor, __LINE__)()

#define kMinMutableCount    8UL
#define kStringBufferLength 256UL
#define NewMutableString() [NSMutableString stringWithCapacity:kStringBufferLength]
#define NewMutableSet() [[NSMutableSet alloc] initWithCapacity:kMinMutableCount]
#define NewMutableArray() [NSMutableArray arrayWithCapacity:kMinMutableCount]
#define NewMutableDictionary() [NSMutableDictionary dictionaryWithCapacity:kMinMutableCount]

#define CopyAsWeakConst(x, y) __weak const typeof(x) y = x

#define CopyOnlyConst(x, y) const typeof(x) y = x

typedef void(^EmptyBlock)();

inline static void runBlockAfter(NSTimeInterval time, dispatch_queue_t queue, dispatch_block_t block)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), queue, block);
}

/**
 *  读xib
 */
#define Xib(x) [[[NSBundle mainBundle]loadNibNamed:x owner:nil options:nil]lastObject]

#endif // ifndef AppMacro_h
