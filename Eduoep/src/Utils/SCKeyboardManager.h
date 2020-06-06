//
//  SCKeyboardManager.h
//  SuanGuo
//
//  Created by lianlian on 7/18/16.
//  Copyright © 2016 lianai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KeyboardManagerInstance [SCKeyboardManager shared]

void closeKeyboard(void);

@protocol SCKeyboardManagerDelegate <NSObject>
@optional
- (void)keyboardWillChangeFrameNotification:(NSNotification *)notify;
- (void)keyboardWillShowNotification:(NSNotification *)notify;
- (void)keyboardDidShowNotification:(NSNotification *)notify;
- (void)keyboardWillHideNotification:(NSNotification *)notify;
@end

@interface SCKeyboardManager : NSObject
@property (nonatomic, weak) id <SCKeyboardManagerDelegate> delegate;

+ (instancetype)shared;

- (void)setKeyboardDelegate:(id <SCKeyboardManagerDelegate>)delegate;
- (void)removeKeyboardDelegate:(id <SCKeyboardManagerDelegate>)delegate;
@end
