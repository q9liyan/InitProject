//
//  MCodeButton.m
//  MengQu
//
//  Created by xxsskk on 2017/11/22.
//  Copyright © 2017年 xxsskk. All rights reserved.
//

#import "MCodeButton.h"
#import "NerdyUI.h"

@interface MCodeButton(){
    int _countdown;
    NSTimer * _countdownTimer;
    NSString *_tttt;
}
@end

@implementation MCodeButton
//@synthesize normalStateImageName = _normalStateImageName;
//@synthesize highlightedStateImageName;
//@synthesize selectedStateImageName;
@synthesize normalStateBgImageName;
@synthesize highlightedStateBgImageName;
@synthesize selectedStateBgImageName;

- (void)pretreat {
    self.countdownBeginNumber = 60;
    self.normalStateBgImageName = @"btn_red_56_normal";
    self.highlightedStateBgImageName = @"btn_red_56_press";
    self.selectedStateBgImageName = @"btn_red_56_press";
//    self.normalStateImageName = @"timerBtn_imageView_normal";
//    self.highlightedStateImageName = @"timerBtn_imageView_highlighted";
//    self.selectedStateImageName = @"timerBtn_imageView_selected";
    self.color(@"#FFFFFF");
    _tttt = @"发验证码";
    self.fnt(14);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [self sharedInit];
    }
    return self;
}

- (id)sharedInit {
    self.backgroundColor = Color(@"255,255,255,0.3");
    [self setupBackgroundNotification];
    [self pretreat];
    [self setupSendSNSCodeButton];
    return self;
}


- (id)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (void)setupBackgroundNotification {
    //页面将要进入前台，开启定时器
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(distantPastTimer)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    //页面消失，进入后台不显示该页面，关闭定时器
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(distantFutureTimer)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)drawRect:(CGRect)rect
{
    _countdown = self.countdownBeginNumber - 1;
    [self setupSendSNSCodeButton];
}

- (void)setupSendSNSCodeButton {

    [self setBackgroundImage:Img(@"#".a(self.normalStateBgImageName)) forState:UIControlStateNormal];
    [self setBackgroundImage:Img(@"#".a(self.highlightedStateBgImageName)) forState:UIControlStateHighlighted];

    [self setTitle:_tttt forState:UIControlStateNormal];
    [self addTarget:self action:@selector(receiveCode) forControlEvents:UIControlEventTouchUpInside];

}

-(void)receiveCode{
    if ([self.delegate respondsToSelector:@selector(snsCodeCountdownButtonClicked)]) {
        [self.delegate snsCodeCountdownButtonClicked];
    }
//    [self initWithCountdownBeginNumber];
}

- (void)initWithCountdownBeginNumber  {
    [self noClick];
    self.color(@"#FFFFFF");
    _countdown = self.countdownBeginNumber - 1;
    [self setTitle:[NSString stringWithFormat:@"%ld秒",self.countdownBeginNumber - 1] forState:UIControlStateNormal];
    
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
}

-(void)closeGetVerifyButtonUser
{
//    [self setBackgroundImage:Img(@"#".a(self.selectedStateBgImageName)) forState:UIControlStateNormal];
    self.color(@"#FFFFFF");
    _countdown = _countdown-1;
    self.userInteractionEnabled = NO;
    [self setTitle:[NSString stringWithFormat:@"%d秒",_countdown] forState:UIControlStateNormal];
    if(_countdown == 0){
        _tttt = @"重新发送";
        [self okClick];
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
    }
}


//页面将要进入前台，开启定时器
-(void)distantPastTimer
{
    //    if([_countdownTimer isValid]&&(_countdown >0))
    //    //开启定时器
    //    [_countdownTimer setFireDate:[NSDate distantPast]];
}

//页面消失，进入后台不显示该页面，关闭定时器
-(void)distantFutureTimer
{
    //    if([_countdownTimer isValid]&&(_countdown >0))
    //    //关闭定时器
    //    [_countdownTimer setFireDate:[NSDate distantFuture]];
}


-(void)reset{
    [_countdownTimer invalidate];
    _countdown = 0;
    _tttt = @"重新发送";
    [self okClick];
}

-(void)noClick{
    if (_countdown > 0) {
        return;
    }
    self.color(@"#FFFFFF");
//    [self setBackgroundImage:Img(@"#".a(self.selectedStateBgImageName)) forState:UIControlStateNormal];
    self.userInteractionEnabled = NO;
}

-(void)okClick{
    if (_countdown > 0) {
        return;
    }
    self.color(@"#FFFFFF");
//    [self setBackgroundImage:Img(@"#".a(self.normalStateBgImageName)) forState:UIControlStateNormal];
    self.userInteractionEnabled = YES;
    [self setTitle:_tttt forState:UIControlStateNormal];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:Nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:Nil];
}

@end
