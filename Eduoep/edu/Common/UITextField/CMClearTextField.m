//
//  CMClearTextField.m
//  ChattingManage
//
//  Created by 刘文志 on 2017/8/1.
//  Copyright © 2017年 YCM. All rights reserved.
//

#import "CMClearTextField.h"

@implementation CMClearTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIButton *button = [self valueForKey:@"_clearButton"];
        [button setImage:[UIImage imageNamed:@"X"] forState:UIControlStateNormal];
        UIImage *highlightImage = [UIImage imageNamed:@"X"];
        highlightImage = [highlightImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [button setImage:highlightImage forState:UIControlStateHighlighted];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return self;
}

- (void)dealloc
{
//    DLog(@"短信登录CMClearTextField释放了");
}

@end
