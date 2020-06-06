//
//  SGAppUtils.h
//  XieHou
//
//  Created by LianAiMini on 14-5-20.
//  Copyright (c) 2014年 Yung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYTextParser.h"
#import <WebKit/WebKit.h>

@class  ShareContent;
@class  NNMessage;
@interface SGAppUtils : NSObject
#pragma mark - 友盟统计

#pragma mark - 获取软件版本
+ (NSInteger)appVersion;
+ (NSString *)appVersionString;
+ (void)saveAppVersionString;  //保存软件版本

#pragma mark - 等级类型 （来了座驾）(新)

#pragma mark - js调用oc方法
+ (void)injectJS:(WKWebView *)webView;
+ (void)performJSMethodWithURL:(NSString *)url protocolName:(NSString *)name performViewController:(UIViewController *)viewController;

//#pragma mark - 保存和读取UUID
//+ (void)saveUUIDToKeyChain;
//+ (NSString *)readUUIDFromKeyChain;

#pragma mark - IAP相关
+ (void)removeIapFailedPath:(NSString *)plistPath;

#pragma mark - 字符串操作
+ (BOOL)checkTextIsNull:(NSString *)string;
// 把表情映射符替换为表情
+ (YYTextSimpleEmoticonParser *)emojiParser;

// 判断光标的前一个是否为表情，如果是表情，返回表情对应的文字长度
+ (NSInteger)lastIsEmotion:(NSString *)textStr;

/**
 *  获取对应字体的字符串所需要的size
 *  @return CGSize
 */
+ (CGSize)sizeWithFont:(UIFont *)font Str:(NSString *)str withMaxWidth:(CGFloat)maxWidth;

/**
 *  检查字符串是否为纯数字
 *
 *  @return BOOL
 */
+ (BOOL)isPureInt:(NSString *)string;

/**
 *  检查手机号是否合法
 *
 *  @return BOOL
 */
+ (BOOL)isValidatePhoneNum:(NSString *)phone;

/**
 *  判断邮箱是否合法
 *
 *  @return BOOL
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  检查空白文本
 *
 *  @return BOOL
 */
+ (BOOL)checkTextIsBlank:(NSString *)string;

#pragma mark - 设备信息

/**
 *  获取设备描述
 *
 *  @return  设备描述
 */
+ (NSString *)deviceString;

/**
 *  是否是iphoen6及以上的设备
 *
 *  @return  YES
 */
+ (BOOL)isiphone6Device;

/**
 *  获取一个UUID
 *  UUID每次生成的值都不一样,需要开发者自行保存UUID.
 *  请使用 getIDFAOrMac 方法
 *  @return UUIDString
 */
+ (NSString *)getUUIDString;

/**
 *  获取mac地址
 *
 *  @return mac Address
 */
+ (NSString *)getMacAddress;

/**
 *  获取设备唯一标识
 *
 *  @return  设备唯一标识
 */
+ (NSString *)getIDFAOrMac;

/**
 *  判断是否越狱
 *
 *  @return BOOL
 */
+ (BOOL)isJailBrokeDevice;

#pragma mark - 颜色相关

/**
 *  根据十六进制字符串返回颜色
 *
 *  @return UICOLOR
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 *  根据十六进制字符串和透明度返回颜色
 *
 *  @return UICOLOR
 */
+ (UIColor *)colorWithHexString:(NSString *)color WithAlpha:(float)alpha;

#pragma mark - 图片相关

/**
 *  根据颜色和大小创建图片
 *
 *  @return UIIMAGE
 */
+ (UIImage *)createImageWithColor:(UIColor *)color withSize:(CGSize)size;

/**
 *  缩放图片到指定大小
 *
 *  @return UIIMAGE
 */
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size;

+ (UIImage *)imageCompressSize:(UIImage *)image;

+ (UIImage *)scale:(UIImage *)image toSize:(CGSize)size;

#pragma mark - 时间相关

/**
 *  返回一个字符串,48小时之内显示xx小时之前,48小时之后显示具体时间:精确到天
 *
 *  @param dateString 时间字符串
 *
 *  @return NSString
 */
+ (NSString *)transform_48Hours_Date:(NSString *)dateString;

+ (NSString *)nowDateString;
+ (NSString *)nowDateInterval;

+ (NSDate *)dateFromString:(NSString *)dateStr;

/**
 *  聊天时间转换
 *
 *  @param date
 *
 */
+ (NSString *)timeOfReceviceMessageWithDate:(NSString *)date;
+ (NSString *)timeOfMessageListWithDate:(NSString *)date;
//毫秒数转换为年月日时分秒的时间
+ (NSString *)ConvertStrToTime:(long long)timeN;

/**
 *  是否需要显示时间
 *
 */
+ (BOOL)showChatTimeWithNowTime:(NSString *)now last:(NSString *)last;

#pragma mark - 提示
+ (void)showMessageOnWindow:(NSString *)message;
+ (void)showAutoHideMessage:(NSString *)message onView:(UIView *)view;
+ (void)showManualHideMessage:(NSString *)message onView:(UIView *)view;
+ (void)showManualHideMessageTap:(NSString *)message onView:(UIView *)view;
+ (void)showHideMessageTap:(NSString *)message onView:(UIView *)view;

//佳人自定义菊花
+ (void)showCustomLoading;
+ (void)hideCustomLoading;


+ (void)hideHUD;
+ (void)hideAllHUD;

+ (void)showMessage:(NSString *)message onView:(UIView *)view whileExecutingBlock:(dispatch_block_t)block;

+ (void)showOnlyMessage:(NSString *)message onView:(UIView *)view completionBlock:(dispatch_block_t)block;

+ (void)showhHinderHUD;

//设置行间距
+(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withSpacing:(CGFloat)space;
//首次关注提示，根据自己的UID来判断，每个UID只显示一次 （我只想说这是一个坑，关注的方法都没有统一，到处都是）
+(void)showAttentionToast;

/**
 判断消息是否过期，

 @param timeStr 过期时间：yyyy-MM-dd HH:mm:ss
 @return 是否过期
 */
+(BOOL)isStaleDated:(NSString *)timeStr;

+ (CGFloat)getScrollSpeed:(NSAttributedString *)str;

+ (NSString *)updateTimeForRow:(NSString *)createTimeString;

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

+ (UIViewController *)getCurrentVC;

#pragma mark --气泡名字
+ (NSString *)chatbgSendWithVip:(int)vip;
+ (NSString *)chatbgReceiveWithVip:(int)vip;


#pragma mark --每天执行一次
+(BOOL)performOnceAtOneDay:(NSString *)actionKey;

+ (CGFloat)calculateRowWidth:(NSString *)string font:(UIFont *)font;


@end
