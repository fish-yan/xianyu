//
//  C_PartJobDeleteCell.m
//  XianYu
//
//  Created by lmh on 2019/7/7.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_PartJobDeleteCell.h"

@implementation C_PartJobDeleteCell

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
    self.jobLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Blue_32A060 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.deleteImageView = [JSFactory creatImageViewWithImageName:@"icon_c_partjob_select_delete"];
    [self addSubview:self.jobLabel];
    [self addSubview:self.deleteImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.jobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(25)));
        make.centerY.equalTo(@0);
    }];
    [self.deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(Anno750(20), Anno750(20)));
    }];
}

@end
