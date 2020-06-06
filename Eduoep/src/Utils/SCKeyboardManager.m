//
//  SCKeyboardManager.m
//  SuanGuo
//
//  Created by lianlian on 7/18/16.
//  Copyright © 2016 lianai. All rights reserved.
//

#import "SCKeyboardManager.h"
#import <UIKit/UIKit.h>

void closeKeyboard()
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

@implementation SCKeyboardManager
+ (instancetype)shared
{

    static SCKeyboardManager *temp = nil;

    if (nil == temp) {
        temp = [[self alloc] init];
        [temp addKeyboardNotify];
    }

    return temp;
}

- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setKeyboardDelegate:(id <SCKeyboardManagerDelegate>)delegate
{

    self.delegate = delegate;
}

- (void)removeKeyboardDelegate:(id <SCKeyboardManagerDelegate>)delegate
{

    if (self.delegate == delegate) {
        self.delegate = nil;
    }
}

- (void)addKeyboardNotify
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)removeKeyboardNotify
{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notify
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardWillChangeFrameNotification:)]) {
        [self.delegate keyboardWillChangeFrameNotification:notify];
    }
}

- (void)keyboardWillShowNotification:(NSNotification *)notify
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardWillShowNotification:)]) {
        [self.delegate keyboardWillShowNotification:notify];
    }
}

- (void)keyboardDidShowNotification:(NSNotification *)notify
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardDidShowNotification:)]) {
        [self.delegate keyboardDidShowNotification:notify];
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)notify
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardWillHideNotification:)]) {
        [self.delegate keyboardWillHideNotification:notify];
    }
}

@end
