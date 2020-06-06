//
//  UIImageView+SGExtension.h
//  SuanGuo
//
//  Created by Mia on 16/3/7.
//  Copyright © 2016年 lianai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SGExtension)

- (void)sd_setImageWithURL:(NSString *)url placeholder:(UIImage *)placeholder;
- (void)sd_circleImage:(NSString *)url placeholder:(UIImage *)placeholder;
@end
