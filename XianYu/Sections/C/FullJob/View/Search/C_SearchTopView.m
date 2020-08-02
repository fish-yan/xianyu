//
//  C_SearchTopView.m
//  XianYu
//
//  Created by lmh on 2019/7/23.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_SearchTopView.h"

@implementation C_SearchTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = Color_Ground_F5F5F5;
    }
    return self;
}

- (void)createUI
{
    self.searchImageView = [JSFactory creatImageViewWithImageName:@"icon_c_search_top"];
    self.printField = [JSFactory creatTextFieldWithPlaceHolder:@"搜索职位名称/公司" textAlignment:(NSTextAlignmentLeft) textColor:Color_Black_464646 textFont:font750(26)];
    [self addSubview:self.searchImageView];
    [self addSubview:self.printField];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@(Anno750(20)));
        make.size.mas_equalTo(CGSizeMake(Anno750(36), Anno750(36)));
    }];
    [self.printField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchImageView.mas_right).offset(Anno750(20));
        make.top.bottom.right.equalTo(@0);
    }];
}

@end
