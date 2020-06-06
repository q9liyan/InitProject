//
//  DatabaseMacro.h
//  SuanGuo
//
//  Created by lianai on 16/3/18.
//  Copyright © 2016年 lianai. All rights reserved.
//

#ifndef DatabaseMacro_h
#define DatabaseMacro_h
#import <UIKit/UIKit.h>

#pragma mark - MessageTable数据列名
// 对应SGMessage模型的属性
/*************************************************MessageTable数据列名******************************/
#define MessageTable_id         @ "id"
#define MessageTable_uid        @ "uid"
#define MessageTable_name       @ "name"
#define MessageTable_head       @ "head"
#define MessageTable_tid        @ "tid"
#define MessageTable_body       @ "body"
#define MessageTable_payload    @ "payload"
#define MessageTable_type       @ "type"
#define MessageTable_state      @ "state"
#define MessageTable_mobileId   @ "mobileId"
#define MessageTable_time       @ "time"
#define MessageTable_timeHint   @ "timeHint"
#define MessageTable_readState  @ "readState"
#define MessageTable_genderStr     @ "genderStr"
#define MessageTable_userList      @ "userList"

// TEXT类型
#define MessageTable_reserved1  @ "M_reserved1"         // 对应PrivateLiveMessage的属性：content
#define MessageTable_reserved2  @ "M_reserved2"         // 对应PrivateLiveMessage的属性：picture
#define MessageTable_reserved3  @ "M_reserved3"         // 对应PrivateLiveMessage的属性：title
#define MessageTable_reserved4  @ "M_reserved4"         // 对应SGMessage的属性：title //2.3.6
#define MessageTable_reserved5  @ "M_reserved5"         // 对应SGMessage的属性：webName 网页标题，遗漏字段
#define MessageTable_reserved6  @ "M_reserved6"         // 对应SGMessage的属性：picture //2.3.6
#define MessageTable_reserved7  @ "M_reserved7"         // 对应SGMessage的属性：image //2.3.6
#define MessageTable_reserved8  @ "M_reserved8"         // 对应SGMessage的属性：button //2.3.6
#define MessageTable_reserved9  @ "M_reserved9"         // 对应SGMessage的属性：url //2.3.6

// Integer类型
#define MessageTable_reserved10 @ "M_reserved10"        // 对应PrivateLiveMessage的属性：target
#define MessageTable_reserved11 @ "M_reserved11"        // 对应PrivateLiveMessage的属性：lid
#define MessageTable_reserved12 @ "M_reserved12"        // 对应SGMessage的属性：target//2.3.6
#define MessageTable_reserved13 @ "M_reserved13"        // 对应SGMessage的属性：vip//2.4
#define MessageTable_reserved14 @ "M_reserved14"        // 对应SGMessage的属性：msgID 跳转目标（可能是直播间可能是他人主页的tid），遗漏字段
#define MessageTable_reserved15 @ "M_reserved15"

#pragma  mark - MessageListTable数据列名
// 对应SGMessageListModel模型的属性
/*************************************************MessageListTable数据列名******************************/
#define MessageListTable_id             @ "id"
#define MessageListTable_uid            @ "uid"
#define MessageListTable_name           @ "name"
#define MessageListTable_head           @ "head"
#define MessageListTable_body           @ "body"
#define MessageListTable_time           @ "time"
#define MessageListTable_unreadCount    @ "unreadCount"
#define MessageListTable_genderStr         @ "genderStr"
#define MessageListTable_userList          @ "userList"
#define MessageListTable_reserved1      @ "reserved1"
#define MessageListTable_reserved2      @ "reserved2"
#define MessageListTable_reserved3      @ "reserved3"
#define MessageListTable_reserved4      @ "reserved4"
#define MessageListTable_reserved5      @ "reserved5"
#define MessageListTable_reserved6      @ "reserved6"
#define MessageListTable_reserved7      @ "reserved7"
//以下都是int
#define MessageListTable_reserved8      @ "reserved8"//vip //2.4
#define MessageListTable_reserved9      @ "reserved9"
#define MessageListTable_reserved10     @ "reserved10"
#define MessageListTable_reserved11     @ "reserved11"
#define MessageListTable_reserved12     @ "reserved12"
#define MessageListTable_reserved13     @ "reserved13"
#define MessageListTable_reserved14     @ "reserved14"
#define MessageListTable_reserved15     @ "reserved15"

#pragma  mark - 数据库表名
/*************************************************数据库表名******************************/
//#define FriendMessageListTable      @ "MessageList_Table"//好友表
//#define noAttentuonMessageListTable @ "noAttentionMessageList_Table"//非好友表
#define MessageTable                @ "message_table"//所有消息的列表 （消息数目总表）
#define kUsersListTable             @ "UserListTable"//消息列表 （好友+非好友）
#define kImportantTipTable             @ "ImportantTipTable"//记录有没有弹出重要提示

#endif /* DatabaseMacro_h */
