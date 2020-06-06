//
//  UIView+AddVirtualLine.h
//  JRLive
//
//  Created by xxsskk on 2020/2/21.
//  Copyright © 2020 xxsskk. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AddVirtualLine)
@property (strong, nonatomic) CAShapeLayer *virtualLine;
- (void)addVirtualLine;//加虚线
- (void)addRealLine;//加实线
@end

NS_ASSUME_NONNULL_END
