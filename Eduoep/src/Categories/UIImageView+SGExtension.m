//
//  UIImageView+SGExtension.m
//  SuanGuo
//
//  Created by Mia on 16/3/7.
//  Copyright © 2016年 lianai. All rights reserved.
//

#import "UIImageView+SGExtension.h"

#import "UIView+SGViewCG.h"
#import "UIImage+Slicing.h"

#undef LogFunctionName
#define LogFunctionName()

@implementation UIImageView (SGExtension)

- (void)sd_setImageWithURL:(NSString *)url placeholder:(UIImage *)placeholder
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         self.image = image ?image : placeholder;
     }];
}
- (void)sd_circleImage:(NSString *)url placeholder:(UIImage *)placeholder
{
    
    //    dispatch_queue_t _UIQuene = dispatch_queue_create("PicQuene", NULL);
    if (self.w != 0) {
        self.corner = self.w/2;
        self.layer.masksToBounds = YES;
    }
    
    
    //    dispatch_async(_UIQuene, ^{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         //             dispatch_async(dispatch_get_main_queue(), ^{
         self.image = image ?[image circleImage] : placeholder;
         //             });
     }];
    //    });
}
@end
