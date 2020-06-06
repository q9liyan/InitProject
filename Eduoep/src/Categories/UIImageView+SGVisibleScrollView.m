//
//  UIImageView+SGVisibleScrollView.m
//  SuanGuo
//
//  Created by 周宇晗 on 21/11/2016.
//  Copyright © 2016 lianai. All rights reserved.
//

#import "UIImageView+SGVisibleScrollView.h"

#define noDisableVerticalScrollTag 836913

@implementation UIImageView (SGVisibleScrollView)

- (void)setAlpha:(CGFloat)alpha
{
    
    if (self.superview.tag == noDisableVerticalScrollTag) {
        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleLeftMargin) {
            if (self.frame.size.width < 10 && self.frame.size.height > self.frame.size.width) {
                UIScrollView *sc = (UIScrollView*)self.superview;
                if (sc.frame.size.height < sc.contentSize.height) {
                    return;
                }
            }
        }
    }
    
    [super setAlpha:alpha];  
}

@end
