//
//  MBaseTextField.m
//  FeiSound
//
//  Created by xxsskk on 2018/8/7.
//  Copyright © 2018年 xxsskk. All rights reserved.
//

#import "MBaseTextField.h"
@interface MBaseTextField()

@end
@implementation MBaseTextField

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setClearButtonAndPlaceholder];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setClearButtonAndPlaceholder];
    }
    return self;
}
- (void)setClearButtonAndPlaceholder{
    [[self valueForKey:@"_clearButton"] setImage:[UIImage imageNamed:@"btn_back_24_normal"] forState:UIControlStateNormal];
    [[self valueForKey:@"_clearButton"] setImage:[UIImage imageNamed:@"btn_back_24_press"] forState:UIControlStateHighlighted];
//    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
//    self.attributedPlaceholder = placeholderString;
    self.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    self.maxCount = INT_MAX;
}
- (void)textFieldTextDidChange
{
    

    NSString    *toBeString = self.text;
    NSString    *lang = [self.textInputMode primaryLanguage];

    if ([lang isEqualToString:@"zh-Hans"]) {  // 简体中文输入
        // 获取高亮部分
        UITextRange     *selectedRange = [self markedTextRange];
        UITextPosition  *position = [self positionFromPosition:selectedRange.start offset:0];

        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > self.maxCount) {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxCount];

                if (rangeIndex.length == 1) {
                    self.text = [toBeString substringToIndex:self.maxCount];
                } else {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.maxCount)];
                    self.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else {
        if (toBeString.length > self.maxCount) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxCount];

            if (rangeIndex.length == 1) {
                self.text = [toBeString substringToIndex:self.maxCount];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.maxCount)];
                self.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}
@end
