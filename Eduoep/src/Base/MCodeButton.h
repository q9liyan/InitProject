//
//  MCodeButton.h
//  MengQu
//
//  Created by xxsskk on 2017/11/22.
//  Copyright © 2017年 xxsskk. All rights reserved.
//
//#import "YoYo乐园-Swift.h"
#import <UIKit/UIKit.h>


@protocol MCodeBtnDelegate <NSObject>

-(void)snsCodeCountdownButtonClicked;

@end

@interface MCodeButton : UIButton

@property (nonatomic, assign) NSInteger countdownBeginNumber;
//@property (nonatomic, copy) NSString *normalStateImageName;
//@property (nonatomic, copy) NSString *highlightedStateImageName;
//@property (nonatomic, copy) NSString *selectedStateImageName;
@property (nonatomic, copy) NSString *normalStateBgImageName;
@property (nonatomic, copy) NSString *highlightedStateBgImageName;
@property (nonatomic, copy) NSString *selectedStateBgImageName;

@property (nonatomic, weak) id<MCodeBtnDelegate> delegate;
/**
 *  页面将要进入前台，开启定时器
 */
-(void)distantPastTimer;
/**
 *  页面消失，进入后台不显示该页面，关闭定时器
 *
 */
-(void)distantFutureTimer;

-(void)noClick;

-(void)okClick;

-(void)reset;

-(void)initWithCountdownBeginNumber;

@end
