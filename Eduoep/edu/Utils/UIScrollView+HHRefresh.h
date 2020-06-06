//
//  UIScrollView+HHRefresh.h
//  WealthPartners
//
//  Created by 李 on 2020/3/16.
//  Copyright © 2020 李. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (HHRefresh)
/**
 添加头部刷新
 */
-(void)addHeaderRefresh:(void(^)(void))block;
/**
 添加尾部刷新
 */
-(void)addFooterRefresh:(void(^)(void))block;

/**
 头部刷新
 */
-(void)beginHeaderRefresh;
/**
 终于头部刷新
 */
-(void)endHeaderRefresh;
/**
 终于尾部刷新
 */
-(void)endFooterRefresh;

/**
 此方法包括头部刷新终止和尾部刷新终于
 */
-(void)endRefresh;

/**
 终止刷新并且设置是否有更多
 */
-(void)endRefreshWithHasMore:(BOOL)hasMore;

/*
 不能继续上拉加载更多，状态变为已加载全部
 */
-(void)endRefreshMoreAbility;

/*
 恢复继续加载更多
 */
-(void)resetRefreshMoreAbility;
@end

NS_ASSUME_NONNULL_END
