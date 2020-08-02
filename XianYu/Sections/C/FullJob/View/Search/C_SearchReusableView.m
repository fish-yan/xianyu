//
//  C_SearchReusableView.m
//  XianYu
//
//  Created by lmh on 2019/7/23.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_SearchReusableView.h"

@implementation C_SearchReusableView

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
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_464646 textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    self.clearButton = [JSFactory creatButtonWithTitle:@"清空" textFont:font750(26) titleColor:Color_Black_A5A5A5 backGroundColor:Color_White];
    [self addSubview:self.nameLabel];
    [self addSubview:self.clearButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@(Anno750(24)));
        make.height.equalTo(@(Anno750(42)));
    }];
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.centerY.equalTo(self.nameLabel);
        make.size.mas_equalTo(CGSizeMake(Anno750(80), Anno750(42)));
    }];
}


@end
