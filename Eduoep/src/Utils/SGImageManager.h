//
//  SGImageManager.h
//  SuanGuo
//
//  Created by kaixuan on 17/1/10.
//  Copyright © 2017年 lianai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGImageManager : NSObject
@property (nonatomic, strong) NSArray *refreshingArry;
@property (nonatomic, strong) NSArray *idleAyyr;

+ (instancetype)shareInstance;

@end
