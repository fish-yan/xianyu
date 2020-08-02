//
//  C_JobInfoHeadView.m
//  XianYu
//
//  Created by lmh on 2019/7/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_JobInfoHeadView.h"

@implementation C_JobInfoHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = Color_White;
    }
    return self;
}

- (void)createUI
{
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_464646 textFont:font750(40) textAlignment:(NSTextAlignmentLeft)];
    [self addSubview:self.nameLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(44)));
        make.centerY.equalTo(@(Anno750(0)));
    }];
}

@end
