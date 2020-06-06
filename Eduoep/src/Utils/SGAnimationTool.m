//
//  SGAnimationTool.m
//  SuanGuo
//
//  Created by xxsskk on 2017/3/29.
//  Copyright © 2017年 lianai. All rights reserved.
//

#import "SGAnimationTool.h"

@implementation SGAnimationTool

+(CABasicAnimation *)SGAnimationWithKeyPath:(NSString *)keyPath withBeginTime:(CFTimeInterval)beginTime withFromValue:(id)fromValue withToValue:(id)toValue withDuration:(CFTimeInterval)duration withRemovedOnCompletion:(BOOL)removedOnCompletion withFillMode:(NSString *)fillMode withTimingFunction:(CAMediaTimingFunction *)timingFunction withDelegate:(id<CAAnimationDelegate>)delegate{
    
    CABasicAnimation    *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    if (beginTime) {
         animation.beginTime = beginTime;
    }
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.duration = duration;
    if (removedOnCompletion == NO) {
        //默认是YES；j
        animation.removedOnCompletion = removedOnCompletion;
    }
    if (fillMode) {
        animation.fillMode = fillMode;
    }
    if (timingFunction) {
        animation.timingFunction = timingFunction;
    }
    if (delegate) {
        animation.delegate = delegate;
    }
    return animation;
}

@end
