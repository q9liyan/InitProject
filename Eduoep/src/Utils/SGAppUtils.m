//
//  SGAppUtils.m
//  XieHou
//
//  Created by LianAiMini on 14-5-20.
//  Copyright (c) 2014年 Yung. All rights reserved.
//

#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import "SGAppUtils.h"
#import "sys/utsname.h"

#import "NSObject+Extension.h"


#import "AppMacro.h"
#import "MBProgressHUD.h"

#import "NSDate+Utilities.h"

@interface SGAppUtils ()

@end

@implementation SGAppUtils
#pragma mark - 友盟统计

#pragma mark - 获取软件版本
+ (NSInteger)appVersion
{
    NSString *appVersion = [self appVersionString];

    appVersion = [appVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    return appVersion.integerValue;
}

// 读取版本信息
+ (NSString *)appVersionString
{
    NSString *appVersionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    return appVersionString;
}

// 保存版本信息
+ (void)saveAppVersionString {
    
    NSString *version =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:version forKey:CURRENT_VERSION];
    [user synchronize];
}

#pragma mark - js调用oc方法
+ (void)performJSMethodWithURL:(NSString *)url protocolName:(NSString *)name performViewController:(UIViewController *)viewController
{
    /*
     *   url ：           xmg://sendMessage_number2_number3_*100$100$99
     *   protocolName：   xmg://
     *   方法名：          sendMessage:number2:number3
     *   参数：            100，100，99
     *
     *   方法名和参数组合为oc的方法为：- (void)sendMessage:(NSString *)number number2:(NSString *)number2 number3:(NSString *)number3
     */

    // 获得协议后面的路径为： sendMessage_number2_*200$300
    NSString *path = [url substringFromIndex:name.length];

    // 利用“*”切割路径，“*”前面是方法名，后面是参数
    NSArray *subpaths = [path componentsSeparatedByString:@"*"];

    // 方法名 methodName == sendMessage:number2:
    // 下面的方法是把"_"替换为"?', js返回的url里面把“:”直接省略了，只能在js里面使用“_”来表示，然后在oc里面再替换回“:”
    NSString *methodName = [[subpaths firstObject] stringByReplacingOccurrencesOfString:@"_" withString:@":"];

    // 参数  200$300，每个参数之间使用符号$链接（避免和url里面的其他字符混淆，因为一般url里面不会出现这个字符）
    NSArray *params = nil;

    if (subpaths.count == 2) {
        params = [[subpaths lastObject] componentsSeparatedByString:@"$"];
    }
    // 调用NSObject类扩展方法，传递多个参数
    [viewController performSelector:NSSelectorFromString(methodName) withObjects:params];
}

+ (void)injectJS:(WKWebView *)webView
{
    // js方法遍历图片添加点击事件 返回图片个数
    static NSString *const jsGetImages =
        @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    if(i ==2){\
    objs[i].onclick=function(){\
    document.location.href=\"jscallbackoc://saveImage_*\"+\"http://7o52k2.com1.z0.glb.clouddn.com/mobile/contact/erweima.png\";\
    };\
    };\
    };\
    return objs.length;\
    };";
    
    [webView evaluateJavaScript:jsGetImages completionHandler:nil];// 注入js方法
    // 注入自定义的js方法后别忘了调用 否则不会生效
    [webView evaluateJavaScript:@"getImages()" completionHandler:nil];// 调用js方法

    // 禁用用户选择
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];

    // 禁用长按弹出框
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
}


#pragma mark - IAP成功，移除存储的receipt
+ (void)removeIapFailedPath:(NSString *)plistPath
{
    NSString *path = [NSString stringWithFormat:@"%@/%@", AppStoreInfoLocalFilePath, plistPath];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:AppStoreInfoLocalFilePath]) {
        [fileManager removeItemAtPath:AppStoreInfoLocalFilePath error:nil];
    }

    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:nil];
    }
}

#pragma mark - 字符串操作

+ (BOOL)checkTextIsNull:(NSString *)string
{
    NSString *tempString = [NSString stringWithString:string];

    tempString = [tempString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];

    if ([tempString isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

/*把包含表情映射符的消息转换为表情图片
 *   如下所示：
 *   收到的消息转换前为：你在干嘛[哈哈]
 *         转换后为：你在干嘛😀
 */
+ (YYTextSimpleEmoticonParser *)emojiParser
{
    YYTextSimpleEmoticonParser  *parser = [YYTextSimpleEmoticonParser new];
    NSDictionary    *smallMsgImgDic = [[NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/EmojiMap.plist", [[NSBundle mainBundle] resourcePath]]]objectForKey:@"SmallMsgImg"];
    parser.emoticonMapper = smallMsgImgDic;
    return parser;
}

// 判断光标的前一个是否为表情，如果是表情，返回表情对应的文字长度
+ (NSInteger)lastIsEmotion:(NSString *)textStr
{
    NSDictionary    *smallMsgImgDic = [[NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/EmojiMap.plist", [[NSBundle mainBundle] resourcePath]]]objectForKey:@"SmallMsgImg"];
    NSArray         *smallKeyArray = [smallMsgImgDic allKeys];

    for (NSString *keyStr in smallKeyArray) {
        if ([textStr hasSuffix:keyStr]) {
            return keyStr.length;
        }
    }

    return 1;
}

+ (CGSize)sizeWithFont:(UIFont *)font Str:(NSString *)str withMaxWidth:(CGFloat)maxWidth
{
    NSDictionary    *attribute = @{NSFontAttributeName:font};
    CGRect          rect = [str boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
        options     :(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
        attributes  :attribute
        context     :nil];

    return rect.size;
}

+ (BOOL)checkTextIsBlank:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];

    if ([string isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

// 判断手机是否合法
+ (BOOL)isValidatePhoneNum:(NSString *)phone
{
    // 因为太多新增号码段无法使用该方法判断手机号码只能判断第一位是不是1
    //    NSString *phoneRegex = @"^((147)|((13|15|18)[0-9]))\\d{8}$";//@"\\d{3}-\\d{8}|\\d{4}-\\d{7}|\\d{11}";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    return [phoneTest evaluateWithObject:phone];

    if (phone && (phone.length == 11) && [[phone substringToIndex:1] isEqualToString:@"1"]) {
        return YES;
    } else {
        return NO;
    }
}

// 判断邮箱是否合法
+ (BOOL)validateEmail:(NSString *)email
{
    NSString    *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isPureInt:(NSString *)string
{
    NSScanner   *scan = [NSScanner scannerWithString:string];
    int         val;

    return [scan scanInt:&val] && [scan isAtEnd];
}



+ (NSString *)getMacAddress
{
//    if (SystemVersion >= 7.0) {
//        return nil;
//    }

    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;

    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;          // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;         // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;          // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;    // Request all configured interfaces

    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0) {
        errorFlag = @"if_nametoindex failure";
    } else {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0) {
            errorFlag = @"sysctl mgmtInfoBase failure";
        } else {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL) {
                errorFlag = @"buffer allocation failure";
            } else {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0) {
                    errorFlag = @"sysctl msgBuffer failure";
                }
            }
        }
    }

    // Befor going any further...
    if (errorFlag != NULL) {
        free(msgBuffer);
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }

    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *)msgBuffer;

    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *)(interfaceMsgStruct + 1);

    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);

    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
        macAddress[0], macAddress[1], macAddress[2],
        macAddress[3], macAddress[4], macAddress[5]];

    NSLog(@"Mac Address: %@", macAddressString);

    // Release the buffer memory
    free(msgBuffer);

    return macAddressString;
}

+ (NSString *)deviceString
{
    struct utsname systemInfo;

    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    if ([platform isEqualToString:@"iPhone1,1"]) {
        return @"iPhone 2G";
    }

    if ([platform isEqualToString:@"iPhone1,2"]) {
        return @"iPhone 3G";
    }

    if ([platform isEqualToString:@"iPhone2,1"]) {
        return @"iPhone 3GS";
    }

    if ([platform isEqualToString:@"iPhone3,1"]) {
        return @"iPhone 4";
    }

    if ([platform isEqualToString:@"iPhone3,2"]) {
        return @"iPhone 4";
    }

    if ([platform isEqualToString:@"iPhone3,3"]) {
        return @"iPhone 4 (CDMA)";
    }

    if ([platform isEqualToString:@"iPhone4,1"]) {
        return @"iPhone 4S";
    }

    if ([platform isEqualToString:@"iPhone5,1"]) {
        return @"iPhone 5";
    }

    if ([platform isEqualToString:@"iPhone5,2"]) {
        return @"iPhone 5 (GSM+CDMA)";
    }

    if ([platform isEqualToString:@"iPhone5,1"]) {
        return @"iPhone 5 (A1428)";
    }

    if ([platform isEqualToString:@"iPhone5,2"]) {
        return @"iPhone 5 (A1429/A1442)";
    }

    if ([platform isEqualToString:@"iPhone5,3"]) {
        return @"iPhone 5c (A1456/A1532)";
    }

    if ([platform isEqualToString:@"iPhone5,4"]) {
        return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    }

    if ([platform isEqualToString:@"iPhone6,1"]) {
        return @"iPhone 5s (A1453/A1533)";
    }

    if ([platform isEqualToString:@"iPhone6,2"]) {
        return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    }

    if ([platform isEqualToString:@"iPhone7,1"]) {
        return @"iPhone 6 Plus (A1522/A1524)";
    }

    if ([platform isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6 (A1549/A1586)";
    }
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    if ([platform isEqualToString:@"iPod1,1"]) {
        return @"iPod Touch (1 Gen)";
    }

    if ([platform isEqualToString:@"iPod2,1"]) {
        return @"iPod Touch (2 Gen)";
    }

    if ([platform isEqualToString:@"iPod3,1"]) {
        return @"iPod Touch (3 Gen)";
    }

    if ([platform isEqualToString:@"iPod4,1"]) {
        return @"iPod Touch (4 Gen)";
    }

    if ([platform isEqualToString:@"iPod5,1"]) {
        return @"iPod Touch (5 Gen)";
    }

    if ([platform isEqualToString:@"iPad1,1"]) {
        return @"iPad";
    }

    if ([platform isEqualToString:@"iPad1,2"]) {
        return @"iPad 3G";
    }

    if ([platform isEqualToString:@"iPad2,1"]) {
        return @"iPad 2 (WiFi)";
    }

    if ([platform isEqualToString:@"iPad2,2"]) {
        return @"iPad 2";
    }

    if ([platform isEqualToString:@"iPad2,3"]) {
        return @"iPad 2 (CDMA)";
    }

    if ([platform isEqualToString:@"iPad2,4"]) {
        return @"iPad 2";
    }

    if ([platform isEqualToString:@"iPad3,1"]) {
        return @"iPad 3 (WiFi)";
    }

    if ([platform isEqualToString:@"iPad3,2"]) {
        return @"iPad 3 (GSM+CDMA)";
    }

    if ([platform isEqualToString:@"iPad3,3"]) {
        return @"iPad 3";
    }

    if ([platform isEqualToString:@"iPad3,4"]) {
        return @"iPad 4 (WiFi)";
    }

    if ([platform isEqualToString:@"iPad3,5"]) {
        return @"iPad 4";
    }

    if ([platform isEqualToString:@"iPad3,6"]) {
        return @"iPad 4 (GSM+CDMA)";
    }

    if ([platform isEqualToString:@"iPad2,5"]) {
        return @"iPad Mini (WiFi)";
    }

    if ([platform isEqualToString:@"iPad2,6"]) {
        return @"iPad Mini";
    }

    if ([platform isEqualToString:@"iPad2,7"]) {
        return @"iPad Mini (GSM+CDMA)";
    }

    if ([platform isEqualToString:@"i386"]) {
        return @"Simulator";
    }

    if ([platform isEqualToString:@"x86_64"]) {
        return @"Simulator";
    }
    
    else{
        return [NSString stringWithFormat:@"未统计设备型号 %@",platform];
    }

//    return platform;
}

+(BOOL)isiphone6Device{
    NSString *ss = [[self class] deviceString];
    if ([ss containsString:@"iPhone 5"]||[ss containsString:@"iPhone 4"]) {
        return NO;
    }else{
        return YES;
    }
}

static const char *jailbreak_apps[] =
{
    "/Applications/Cydia.app",
    "/Applications/blackra1n.app",
    "/Applications/blacksn0w.app",
    "/Applications/greenpois0n.app",
    "/Applications/limera1n.app",
    "/Applications/redsn0w.app",
    NULL,
};

+ (BOOL)isJailBrokeDevice
{
    for (int i = 0; jailbreak_apps[i] != NULL; ++i) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_apps[i]]]) {
            return YES;
        }
    }

    return NO;
}

#pragma mark - 颜色相关
+ (UIColor *)colorWithHexString:(NSString *)color
{
    @try {
        
        NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        
        // String should be 6 or 8 characters
        if ([cString length] < 6) {
            return [UIColor clearColor];
        }
        
        // strip 0X if it appears
        if ([cString hasPrefix:@"0X"]) {
            cString = [cString substringFromIndex:2];
        }
        
        if ([cString hasPrefix:@"#"]) {
            cString = [cString substringFromIndex:1];
        }
        
        if ([cString length] != 6) {
            return [UIColor clearColor];
        }
        
        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        
        // r
        NSString *rString = [cString substringWithRange:range];
        
        // g
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        
        // b
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1.0f];
    } @catch (NSException *exception) {
        
    }
}

+ (UIColor *)colorWithHexString:(NSString *)color WithAlpha:(float)alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }

    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }

    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }

    if ([cString length] != 6) {
        return [UIColor clearColor];
    }

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;

    // r
    NSString *rString = [cString substringWithRange:range];

    // g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    // b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

#pragma mark - 图片相关
+ (UIImage *)createImageWithColor:(UIColor *)color withSize:(CGSize)size
{
    CGRect rect = (CGRect) {0, 0, size};

    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

// 只压缩尺寸,不压缩质量,需要再压质量的,自己调UIImageJPEGRepresentation(squareImage, 0.6);方法压缩
+ (UIImage *)imageCompressSize:(UIImage *)image
{
    // 压缩大图
    CGFloat imageWidth = 320 * 2;
    CGSize  bigNewSize;

    bigNewSize = CGSizeMake(imageWidth, imageWidth * image.size.height / image.size.width);

    UIGraphicsBeginImageContext(bigNewSize);
    [image drawInRect:CGRectMake(0, 0, bigNewSize.width, bigNewSize.height + 1)];
    UIImage *bigNewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return bigNewImage;
}

+ (UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

static MBProgressHUD *_hud;
static UIView * hudView;
+ (void)showMessageOnWindow:(NSString *)message
{
    [self showAutoHideMessage:message onView:[UIApplication sharedApplication].delegate.window];
}

+ (void)showAutoHideMessage:(NSString *)message onView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (!message.length) {
            return;
        }
        
        if (![self isOnlyHUD]) {
            return;
        }
        
        _hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        _hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
        _hud.corner = 20.f;
        _hud.detailsLabelText = message;
        _hud.mode = MBProgressHUDModeText;
        [_hud hide:YES afterDelay:1];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            _hud = nil;
        });
    });
}

+ (void)showManualHideMessage:(NSString *)message onView:(UIView *)view
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (![NSThread isMainThread]) {
            return;
        }
        
        if (![self isOnlyHUD]) {
            return;
        }
        
        _hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        _hud.labelText = message;
        _hud.corner = 20.f;
        _hud.mode = MBProgressHUDModeIndeterminate;
        
    });
}
+(void)showHideMessageTap:(NSString *)message onView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (![NSThread isMainThread]) {
            return;
        }
        
        if (![self isOnlyHUD]) {
            return;
        }
        
        _hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        _hud.userInteractionEnabled = NO;
        _hud.labelText = message;
        _hud.corner = 20.f;
        _hud.mode = MBProgressHUDModeText;
        [_hud hide:YES afterDelay:1];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            _hud = nil;
        });
    });
}
+ (void)showManualHideMessageTap:(NSString *)message onView:(UIView *)view
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (![NSThread isMainThread]) {
            return;
        }
        
        if (![self isOnlyHUD]) {
            return;
        }
        
        _hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        _hud.userInteractionEnabled = NO;
        _hud.labelText = message;
        _hud.corner = 20.f;
        _hud.mode = MBProgressHUDModeText;
    });
}

+ (void)showhHinderHUD
{
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        _hud.mode = MBProgressHUDModeIndeterminate;
//        _hud.opacity = 0.0f;
    });
}
+ (void)hideCustomLoading{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (hudView) {
            [hudView setHidden:YES];
            [hudView removeFromSuperview];
            hudView = nil;
        }
    });
}
+ (void)showCustomLoading{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    // 添加hud
    hudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [hudView setBackgroundColor:[UIColor clearColor]];
    [window addSubview:hudView];
    
    // 添加自定义内容（也可以封装到CQHudView里）
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    contentView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    [contentView setBackgroundColor:[UIColor whiteColor]];
    contentView.layer.cornerRadius = 16;
    [hudView addSubview:contentView];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    imageView.center = CGPointMake(contentView.frame.size.width/2, contentView.frame.size.height/2);
    imageView.image = [UIImage imageNamed:@"pic_loading"];
    
    
    //------- 旋转动画 -------//
//    CABasicAnimation *animation = [CABasicAnimation
//                                   animationWithKeyPath: @"transform"];
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    // 围绕Z轴旋转，垂直与屏幕
//    animation.fromValue = [NSValue valueWithCATransform3D:
//                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0)];
//    animation.duration = 0.75;
//    // 旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
//    animation.cumulative = YES;
//    animation.repeatCount = 1000;
    
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat: 0];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = 0.75;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INT_MAX;
    
//    //在图片边缘添加一个像素的透明区域，去图片锯齿
//    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
//    UIGraphicsBeginImageContext(imageRrect.size);
//    [imageView.image drawInRect:CGRectMake(1,1,imageView.frame.size.width-2,imageView.frame.size.height-2)];
//    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    // 添加动画
    [imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [contentView addSubview:imageView];
}

+ (void)hideHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_hud) {
            [_hud hide:YES];
            _hud = nil;
        }
    });
}

+ (BOOL)isOnlyHUD {
    
    if (_hud != nil) {
        return NO;
    }
    
    return YES;
}

+ (void)hideAllHUD {
    
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].delegate.window animated:YES];
}

+ (void)showMessage:(NSString *)message onView:(UIView *)view whileExecutingBlock:(dispatch_block_t)block
{
    
    if (![self isOnlyHUD]) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _hud = [[MBProgressHUD alloc]initWithView:view];
        
        [view addSubview:_hud];
        _hud.removeFromSuperViewOnHide = YES;
        _hud.labelText = message;
        _hud.corner = 20.f;
        _hud.mode = MBProgressHUDModeIndeterminate;
        [_hud showAnimated:YES whileExecutingBlock:block];
    });
}

+ (void)showOnlyMessage:(NSString *)message onView:(UIView *)view completionBlock:(dispatch_block_t)block
{
    [SGAppUtils hideAllHUD];
    _hud = nil;
//    if (![self isOnlyHUD]) {
//        return;
//    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _hud = [[MBProgressHUD alloc]initWithView:view];
        
        [view addSubview:_hud];
        _hud.removeFromSuperViewOnHide = YES;
        _hud.labelText = message;
        _hud.corner = 20.f;
        _hud.minShowTime = 1.7f;
        _hud.mode = MBProgressHUDModeText;
        [_hud showAnimated:YES whileExecutingBlock:^{} completionBlock:block];
    });
}

#pragma mark - 时间相关
+ (NSString *)transform_48Hours_Date:(NSString *)dateString
{
    // 转成成nsdate
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSLocale        *locale = [NSLocale currentLocale];

    [df setLocale:locale];

    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *transformDate = [df dateFromString:dateString];

    NSString *transformDateString = nil;

    NSDateComponents    *nowComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit fromDate:[NSDate date]];
    NSInteger           nowDay = [nowComponents day];
    NSInteger           nowMonth = [nowComponents month];
    NSInteger           nowYear = [nowComponents year];
    NSInteger           nowHours = [nowComponents hour];

    NSDateComponents    *transformComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit fromDate:transformDate];
    NSInteger           transformDay = [transformComponents day];
    NSInteger           transformMonth = [transformComponents month];
    NSInteger           transformYear = [transformComponents year];
    NSInteger           transformHours = [transformComponents hour];

    if ((nowYear == transformYear) && (nowMonth == transformMonth) && ((nowDay - transformDay) < 2)) {
        if ((nowDay - transformDay) == 1) {
            NSInteger hourInterval = 24 - transformHours + nowHours;
            transformDateString = [NSString stringWithFormat:@"%zd小时前", hourInterval];
        } else {
            NSInteger hourInterval = nowHours - transformHours;
            transformDateString = [NSString stringWithFormat:@"%zd小时前", hourInterval <= 0 ? 1 : hourInterval];
        }
    } else {
        df.dateFormat = @"yyyy-MM-dd";
        transformDateString = [df stringFromDate:transformDate];
    }

    return transformDateString;
}

+ (NSString *)nowDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];

    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter stringFromDate:[NSDate date]];
}
+ (NSString *)nowDateInterval
{
    NSDate *datenow = [NSDate date];
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
        return timeSp;
}

+ (NSDate *)dateFromString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];

    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    return [dateFormatter dateFromString:dateStr];
}

/*处理接受到的消息的时间显示**/
+ (NSString *)timeOfReceviceMessageWithDate:(NSString *)date
{
    NSString *dateString = [[NSString alloc] init];

    @try {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        NSLocale        *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [df setLocale:locale];
        df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *msgDate = [df dateFromString:date];

        // 消息的年月日
        NSDateComponents    *messageComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit fromDate:msgDate];
        NSInteger           messageDay = [messageComponents day];
        NSInteger           messageMonth = [messageComponents month];
        NSDateFormatter     *dateFormatter = [[NSDateFormatter alloc] init];

        if ([msgDate isToday]) {// 今天收到的消息
            dateFormatter.dateFormat = @"HH:mm";
            dateString = [dateFormatter stringFromDate:msgDate];
        } else if ([msgDate isYesterday]) {// 昨天收到的消息
            dateFormatter.dateFormat = @"HH:mm";
            dateString = [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:msgDate]];
        } else if (![msgDate isYesterday] && [msgDate isThisWeek]) {// 昨天之前但是本周内收到的消息
            df.dateFormat = @"EEEE HH:mm";
            dateString = [df stringFromDate:msgDate];
        } else if ([msgDate isThisYear] && ![msgDate isThisWeek]) {// 本周以前但是今年内收到的消息
            dateFormatter.dateFormat = [NSString stringWithFormat:@"%@月%@日 HH:mm", messageMonth > 9 ? @"MM" : @"M", messageDay > 9 ? @"dd" : @"d"];
            dateString = [dateFormatter stringFromDate:msgDate];
        } else if (![msgDate isThisYear]) {// 今年之前收到的消息
            dateFormatter.dateFormat = [NSString stringWithFormat:@"yyyy年%@月%@日 HH:mm", messageMonth > 9 ? @"MM" : @"M", messageDay > 9 ? @"dd" : @"d"];
            dateString = [dateFormatter stringFromDate:msgDate];
        }
    } @catch(NSException *exception) {
        dateString = @"时间格式错误";
    } @finally {}

    return dateString;
}

/*处理消息列表的时间显示**/
+ (NSString *)timeOfMessageListWithDate:(NSString *)date
{
    if (!date.length) {
        return @"";
    }
    
    if (![date containsString:@":"]) {
         NSTimeInterval time=[date doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
             NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
             //设定时间格式,这里可以设置成自己需要的格式
                 [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
             NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
             date = currentDateStr;
    }
    
    NSString *dateString = [[NSString alloc] init];

    @try {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        NSLocale        *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [df setLocale:locale];
        df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *msgDate = [df dateFromString:date];

        // 消息的年月日
        NSDateComponents    *messageComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit fromDate:msgDate];
        NSInteger           messageDay = [messageComponents day];
        NSInteger           messageMonth = [messageComponents month];
        NSDateFormatter     *dateFormatter = [[NSDateFormatter alloc] init];

        if ([msgDate isToday]) {// 今天收到的消息
            dateFormatter.dateFormat = @"HH:mm";
            dateString = [dateFormatter stringFromDate:msgDate];
        } else if ([msgDate isYesterday]) {                             // 昨天收到的消息
            dateString = @"昨天";
        } else if (![msgDate isYesterday] && [msgDate isThisWeek]) {    // 昨天之前但是本周内收到的消息
            df.dateFormat = @"EEEE";
            dateString = [df stringFromDate:msgDate];
        } else if ([msgDate isThisYear] && ![msgDate isThisWeek]) {// 本周以前但是今年内收到的消息
            dateFormatter.dateFormat = [NSString stringWithFormat:@"%@月%@日", messageMonth > 9 ? @"MM" : @"M", messageDay > 9 ? @"dd" : @"d"];
            dateString = [dateFormatter stringFromDate:msgDate];
        } else if (![msgDate isThisYear]) {// 今年之前收到的消息
            dateFormatter.dateFormat = [NSString stringWithFormat:@"yyyy年%@月%@日", messageMonth > 9 ? @"MM" : @"M", messageDay > 9 ? @"dd" : @"d"];
            dateString = [dateFormatter stringFromDate:msgDate];
        }
    } @catch(NSException *exception) {
        dateString = @"时间格式错误";
    } @finally {}

    return dateString;
}

/*两条消息的时间间隔是否大于5min**/
+ (BOOL)showChatTimeWithNowTime:(NSString *)now last:(NSString *)last
{
    if (!last) {
        return YES;
    }
    NSDate          *lastDate = [SGAppUtils dateFromString:[SGAppUtils ConvertStrToTime:last.longLongValue]];
    NSDate          *nowDate = [SGAppUtils dateFromString:[SGAppUtils ConvertStrToTime:now.longLongValue]];
    NSTimeInterval  interval = [lastDate timeIntervalSinceDate:nowDate];
    return fabs(interval) >= (5 * 60.0);
}

//毫秒数转换为年月日时分秒的时间
+ (NSString *)ConvertStrToTime:(long long)timeN
{
    
    long long time=timeN;
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString*timeString=[formatter stringFromDate:d];
    
    return timeString;
    
}

+ (UIImage *)fetchBaDaoImage:(NSInteger)starCurrency {
    UIImage *image;
    if (starCurrency == 0) {
        starCurrency = 1;
    }
    if (starCurrency > 0 && starCurrency <= 50) {
        NSString *imgStr = [NSString stringWithFormat:@"tab_badao_%d",(int)starCurrency];
        image = [UIImage imageNamed:imgStr];
    }
    if (starCurrency > 50) {
        image = [UIImage imageNamed:@"tab_badao_50"];
    }
    return image;
}

+ (UIImage *)fetchChaoXingImage:(NSInteger)starCurrency {
    UIImage *image;
    if (starCurrency == 0) {
        starCurrency = 1;
    }
    if (starCurrency > 0 && starCurrency <= 50) {
        NSString *imgStr = [NSString stringWithFormat:@"tab_chaoxing_%d",(int)starCurrency];
        image = [UIImage imageNamed:imgStr];
    }
    if (starCurrency > 50) {
        image = [UIImage imageNamed:@"tab_chaoxing_50"];
    }
    return image;
}

+ (UIImage *)fetchZhouXingImage:(NSInteger)starCurrency {
    UIImage *image;
    if (starCurrency == 0) {
        starCurrency = 1;
    }
    if (starCurrency > 0 && starCurrency <= 50) {
        NSString *imgStr = [NSString stringWithFormat:@"tab_zhouxing_%d",(int)starCurrency];
        image = [UIImage imageNamed:imgStr];
    }
    if (starCurrency > 50) {
        image = [UIImage imageNamed:@"tab_zhouxing_50"];
    }
    return image;
}

+(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withSpacing:(CGFloat)space{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = space; //设置行间距
    //设置字间距 NSKernAttributeName:@1.5f
    paraStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *dic = @{NSParagraphStyleAttributeName:paraStyle};
    
    if (str==nil) {
        str = @"";
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}


+ (void)showAttentionToast{
//    if (![[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"kShowAttention_uid%@",[SGUserInfoManager instance].uid]]) {
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"kShowAttention_uid%@",[SGUserInfoManager instance].uid]];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [SGAppUtils showMessageOnWindow:@"关注成功"];
//    }
    [SGAppUtils showMessageOnWindow:@"关注成功"];
}

+ (BOOL)isStaleDated:(NSString *)timeStr {
    if (!timeStr || timeStr.length == 0) {
        return NO;
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [format dateFromString:timeStr];
    NSDate *nowDate = [NSDate date];
    
    NSComparisonResult result = [nowDate compare:date];
    if (result == NSOrderedAscending) { // 升序, 越往右边越大
        NSLog(@"date > nowDate");
        return NO;
    }else return YES;
}

+ (CGFloat)getScrollSpeed:(NSAttributedString *)str {
	
	CGFloat speed = 80;
	
	return speed;
}

//createTimeString为后台传过来的13位纯数字时间戳
+ (NSString *)updateTimeForRow:(NSString *)createTimeString {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = [createTimeString longLongValue]/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    NSInteger sec = time/60;
    if (sec<60) {
        if (sec < 1) {
            return [NSString stringWithFormat:@"刚刚"];
        }
        return [NSString stringWithFormat:@"%ld分钟前",sec];
    }
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (UIViewController *)getCurrentVC {
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}

+ (NSDictionary *)jumpUrl:(NSString *)url{
    if ([url containsString:@"nuannuan://"]) {
        NSString *baseStr = [url componentsSeparatedByString:@"nuannuan://"][1];
        
        NSData *data = [[NSData alloc]initWithBase64EncodedString:baseStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        if (string == nil)
        {
            return nil;
        }
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding]; NSError *err; NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if(err)
        {
            NSLog(@"json解析失败：%@",err);
            return nil;
        }
        return dic;
        
    }else{
        
        return nil;
    }
}

#pragma mark --气泡名字

+ (NSString *)chatbgSendWithVip:(int)vip{
    return @"pic_mychat_45_normal";
}
+ (NSString *)chatbgReceiveWithVip:(int)vip{
    return @"pic_chat_45_normal";
}
#pragma mark --每天执行一次
+(BOOL)performOnceAtOneDay:(NSString *)actionKey{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //    NSLog(@"之前时间：%@", [userDefault objectForKey:@"nowDate"]);//之前存储的时间
    //    NSLog(@"现在时间%@",[NSDate date]);//现在的时间
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *nowDateString = [dateFormatter stringFromDate:now];
    NSString *realKey = [actionKey stringByAppendingString:nowDateString];
    
    NSDate *agoDate = [userDefault objectForKey:realKey];
        
    
    
        
    NSString *ageDateString = [dateFormatter stringFromDate:agoDate];
    
    //    NSLog(@"日期比较：之前：%@ 现在：%@",ageDateString,nowDateString);
        
    if ([ageDateString isEqualToString:nowDateString]) {
        NSLog(@"已经执行过了");
        return YES;
     }else{
        // 需要执行的方法写在这里

        NSDate *nowDate = [NSDate date];
        NSUserDefaults *dataUser = [NSUserDefaults standardUserDefaults];
        [dataUser setObject:nowDate forKey:realKey];
        [dataUser synchronize];
         
        //需要马上执行一次
        return NO;
     }
}

+ (CGFloat)calculateRowWidth:(NSString *)string font:(UIFont *)font{
    
    NSDictionary *dic = @{NSFontAttributeName:font};
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, CGFLOAT_MAX)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   
     NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    return rect.size.width;

}

@end
