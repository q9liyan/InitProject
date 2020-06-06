//
//  UIImage+Slicing.h
//  SuanGuo
//
//  Created by lianai on 16/3/4.
//  Copyright © 2016年 lianai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+SGExtension.h"

@interface UIImage (Slicing)

/**
 *  UIImageResizingModeStretch
 *
 *  @param imageName
 *
 *  @return UIImage
 */
+ (instancetype)slicingImageNamed:(NSString *)imageName;

/**
 *  裁剪图片为圆形
 *
 */
- (UIImage *)circleImage;

+ (UIImage *)placeholderImage;
@end
