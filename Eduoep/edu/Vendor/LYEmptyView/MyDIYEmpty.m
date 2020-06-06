//
//  MyDIYEmpty.m
//  CYLTabBarController
//
//  Created by ArvinYi on 2018/12/5.
//  Copyright © 2018年 ArvinYi. All rights reserved.
//

#import "MyDIYEmpty.h"

@implementation MyDIYEmpty

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (instancetype)diyNoDataEmpty {
    return [MyDIYEmpty emptyViewWithImageStr:nil
                                    titleStr:NSLocalizedString(@"NO_RESULTS_TITLE", @"抱歉，没有找到符合条件的信息")
                                   detailStr:nil];
}


@end
