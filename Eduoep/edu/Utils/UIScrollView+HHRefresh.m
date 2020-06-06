//
//  UIScrollView+HHRefresh.m
//  WealthPartners
//
//  Created by 李 on 2020/3/16.
//  Copyright © 2020 李. All rights reserved.
//

#import "UIScrollView+HHRefresh.h"
#import <MJRefresh/MJRefresh.h>

@implementation UIScrollView (HHRefresh)
-(void)addHeaderRefresh:(void(^)(void))block{
    
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
}

-(void)addFooterRefresh:(void(^)(void))block{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:block];
}


-(void)beginHeaderRefresh{
    [self.mj_header beginRefreshing];
}

-(void)endHeaderRefresh{
    [self.mj_header endRefreshing];
}

-(void)endFooterRefresh{
    [self.mj_footer endRefreshing];
}

/*终于目前正在刷新的，建议写在tableView刷新之后,在tableView刷新之前终于会出现视图偏移的情况*/
-(void)endRefresh
{
    if([self.mj_header isRefreshing])
        [self.mj_header endRefreshing];
    else if([self.mj_footer isRefreshing])
        [self.mj_footer endRefreshing];
}


-(void)endRefreshWithHasMore:(BOOL)hasMore
{
    if(hasMore){
        [self endRefresh];
        [self resetRefreshMoreAbility];
    }else{
        [self endRefreshMoreAbility];
    }
}


/*
 不能继续上拉加载更多，状态变为已加载全部
 */
-(void)endRefreshMoreAbility
{
    if(self.mj_footer && self.mj_footer.state != MJRefreshStateNoMoreData)
    {
       [self.mj_footer endRefreshingWithNoMoreData];
       if(self.mj_header && self.mj_header.isRefreshing)
           [self.mj_header endRefreshing];
    }
    else if (self.mj_header)
    {
        [self endRefresh];
    }
}

/*
 恢复继续加载更多
 */
-(void)resetRefreshMoreAbility
{
    if(self.mj_footer && self.mj_footer.state == MJRefreshStateNoMoreData)
    {
        [self.mj_footer resetNoMoreData];
    }
}



@end
