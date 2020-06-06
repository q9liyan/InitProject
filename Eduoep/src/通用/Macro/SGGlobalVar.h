//
//  SGGlobalVar.h
//  SuanGuo
//
//  Created by xxsskk on 2017/4/18.
//  Copyright © 2017年 lianai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SGAppLiveStatus) {
    SGAppLiveNoting,        //无状态
    SGAppLivePreview,       //准备直播
    SGAppLiveLiving,        // 直播中(主播)
    SGAppLiveWatching,      // 观看中
};

//排行榜单（魅点，财富，幸运，金币）
typedef NS_ENUM(NSUInteger,JRRankType) {
    JRRankTypeGlamour = 0,//魅点榜
    JRRankTypeRich = 1,//财富榜
    JRRankTypeLucky = 2,//幸福榜
    JRRankTypeGold = 3,//金币榜
};
//排行榜单分榜（日榜，周榜，月榜，总榜）
typedef NS_ENUM(NSUInteger,JRPeriodType) {
    JRPeriodTypeDaily = 0,
    JRPeriodTypeWeekly = 1,
    JRPeriodTypeMonthly = 2,
    JRPeriodTypeAll = 3,
};

typedef NS_ENUM(NSInteger, JRListType) {
    /** 直播间魅点榜单 */
    JRListTypeAtLiveRoom = 0,
    /** “我的”tab ，亲密榜cell*/
    JRListTypeDear,
    /** “排行”tab */
    JRListTypeAtIndex,
};

//extern BOOL Global_App_MainChange;//

extern BOOL Global_App_MainLock;//
extern BOOL Global_App_MainLockUp;//
extern BOOL Global_App_MainLockDown;//

extern NSString *Global_App_DeviceToken;//deviceToken

extern BOOL Global_App_isEnterChatVCFromLiveInterVC;//

extern SGAppLiveStatus Global_APP_LiveStatu;//直播状态

extern NSInteger Global_APP_LiveIDDDDD;//直播ID

extern BOOL Global_App_NotiHead;

extern NSInteger Global_Gift_LoopID;

extern UIViewController *Global_APP_CurrentViewController;//当前VC

extern BOOL Global_App_Switch ;

