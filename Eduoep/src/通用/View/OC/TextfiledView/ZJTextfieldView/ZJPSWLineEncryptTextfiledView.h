//
//  ZJPSWLineEncryptTextfiledView.h
//  ImitateBaiduCourse
//
//  Created by 张君君 on 2019/6/24.
//  Copyright © 2019年 ZhangJunJun. All rights reserved.
//

#import "ZJBaseView.h"
#import "ZJPasswordViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJPSWLineEncryptTextfiledView : ZJBaseView <ZJPasswordViewProtocol>
@property (nonatomic, strong) UILabel *titleLab;
@end

NS_ASSUME_NONNULL_END
