//
//  SGAnimationTool.h
//  SuanGuo
//
//  Created by xxsskk on 2017/3/29.
//  Copyright © 2017年 lianai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/CAAnimation.h>

@interface SGAnimationTool : NSObject

+(CABasicAnimation *)SGAnimationWithKeyPath:(NSString *)keyPath withBeginTime:(CFTimeInterval)beginTime withFromValue:(id)fromValue withToValue:(id)toValue withDuration:(CFTimeInterval)duration withRemovedOnCompletion:(BOOL)removedOnCompletion withFillMode:(NSString *)fillMode withTimingFunction:(CAMediaTimingFunction *)timingFunction withDelegate:(id<CAAnimationDelegate>)delegate;

@end
