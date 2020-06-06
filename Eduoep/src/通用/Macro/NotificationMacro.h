//
//  NotificationMacro.h
//  SuanGuo
//
//  Created by lianai on 16/4/8.
//  Copyright © 2016年 lianai. All rights reserved.
//

#ifndef NotificationMacro_h
  #define NotificationMacro_h

#pragma mark - 未读消息数目发生变化

#define MessageRelation_Key                   @ "MessageRelation_Key"
#define NotificationMessageUnreadCountChange  @ "NotificationMessageUnreadCountChange"
#pragma mark - 用户关系发生变化
#define NotificationRelationChange            @ "NotificationRelationChange"
#define NotificationRelationChangeKey         @ "NotificationRelationChangeKey"    // 0：非好友 1：好友
//#define NotificationRelationChange60          @ "NotificationRelationChange60"
#define NotificationRelationChangeWithUidKey  @ "NotificationRelationChangeWithUidKey"

#define kNotificationLoginOut       @"kNotificationLoginOut"
#define kNotificationLogin       @"kNotificationLogin"
#define kNotificationEnterRoom       @"kNotificationEnterRoom"
#define kNotificationLeaveRoom       @"kNotificationLeaveRoom"

#endif
