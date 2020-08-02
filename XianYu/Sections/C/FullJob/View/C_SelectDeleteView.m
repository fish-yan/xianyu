//
//  C_SelectDeleteView.m
//  XianYu
//
//  Created by lmh on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_SelectDeleteView.h"

@implementation C_SelectDeleteView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = UIColorFromRGB(0xEFF7F2);
    }
    return self;
}

- (void)createUI
{
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Blue_32A060 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.deleteButton = [JSFactory creatButtonWithNormalImage:@"icon_c_partjob_select_delete" selectImage:@"icon_c_partjob_select_delete"];
    [self addSubview:self.nameLabel];
    [self addSubview:self.deleteButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@(Anno750(20)));
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(@0);
        make.width.equalTo(@(Anno750(60)));
    }];
}

@end
