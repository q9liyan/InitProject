//
//  SGImageManager.m
//  SuanGuo
//
//  Created by kaixuan on 17/1/10.
//  Copyright © 2017年 lianai. All rights reserved.
//

#import "SGImageManager.h"

@implementation SGImageManager

+ (instancetype)shareInstance {
    static SGImageManager *imgManager = nil;
    static  dispatch_once_t  onceToken;
    dispatch_once ( &onceToken, ^ {
        imgManager = [ [ SGImageManager alloc ] init ] ;
        
    } );
    
    return imgManager;
}

- (instancetype)init {
    if (self = [super init]) {
        
        /*
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i = 0; i < 30; i++) {
            NSString    *imageName = [NSString stringWithFormat:@"gray_%02d", i];
            UIImage     *image = [UIImage imageNamed:imageName];
            
            if (image) {
                [arrayM addObject:image];
            }
        }
        
        NSMutableArray *scaleArrayM = [NSMutableArray array];
        
        for (int i = 0; i < 31; i++) {
            NSString    *imageName = [NSString stringWithFormat:@"gray_zoom_%zd", i];
            UIImage     *image = [UIImage imageNamed:imageName];
            
            if (image) {
                [scaleArrayM addObject:image];
            }
        }
        
        self.refreshingArry = [NSArray arrayWithArray:arrayM];
        self.idleAyyr = [NSArray arrayWithArray:scaleArrayM];
         */
    }
    return self;
}

@end
