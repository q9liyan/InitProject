//
//  UILabel+AttributeTextTapAction.h
//
//  Created by xxsskk on 17/3/20.
//  Copyright © 2017年 xxsskk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AttributeTapActionDelegate <NSObject>
@optional
/**
 *  AttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)twk_attributeTapReturnString:(NSString *)string
                              range:(NSRange)range
                              index:(NSInteger)index;
@end

@interface AttributeModel : NSObject

@property (nonatomic, copy) NSString *str;

@property (nonatomic, assign) NSRange range;

@end





@interface UILabel (AttributeTextTapAction)

/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)twk_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

/**t
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)twk_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                   delegate:(id <AttributeTapActionDelegate> )delegate;

//事件拦截后额外加的
- (void)touchesBegan:(CGPoint)point;

@end

