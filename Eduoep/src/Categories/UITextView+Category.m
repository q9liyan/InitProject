//
//  UITextView+Category.m
//  Match
//
//  Created by xxsskk on 2017/8/29.
//  Copyright © 2017年 xxsskk. All rights reserved.
//

#import "UITextView+Category.h"

@implementation UITextView (Category)

-(void)m_placeHolder:(NSString *)string color:(UIColor *)color{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = string;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.alpha = 0.8;
    placeHolderLabel.textAlignment = NSTextAlignmentLeft;
    placeHolderLabel.textColor = color;
    [placeHolderLabel sizeToFit];
//    placeHolderLabel.cx = self.w/2;
    [self addSubview:placeHolderLabel];
    placeHolderLabel.font = self.font;
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}

@end
