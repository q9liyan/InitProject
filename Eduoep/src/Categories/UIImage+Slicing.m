//
//  UIImage+Slicing.m
//  SuanGuo
//
//  Created by lianai on 16/3/4.
//  Copyright © 2016年 lianai. All rights reserved.
//

#import "UIImage+Slicing.h"

#undef LogFunctionName
#define LogFunctionName()

@implementation UIImage (Slicing)

+ (instancetype)slicingImageNamed:(NSString *)imageName
{
    

    UIImage *image = [UIImage imageNamed:imageName];

    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5) resizingMode:UIImageResizingModeStretch];
    return image;
}
- (UIImage *)circleImage
{
    

//    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
//    CGContextRef    ctx = UIGraphicsGetCurrentContext();
//    CGRect          rect = CGRectMake(0, 0, self.size.width, self.size.height);
//    // 绘制一个内切圆
//    CGContextAddEllipseInRect(ctx, rect);
//    //按照上面的内切圆裁剪图形上下文
//    CGContextClip(ctx);
//    // 把image绘制到上述矩形框内部，由于矩形框内部已经被裁剪为一个内切圆，所以绘制上去的图片就是一个圆形
//    [self drawInRect:rect];
//    // 从图形上下文获取绘制好的图片
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    return self;
}
+ (UIImage *)placeholderImage {
    
    return [UIImage imageNamed:@"pic_default_head"];
}

@end
