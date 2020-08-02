//
//  C_SearchHeaderView.m
//  XianYu
//
//  Created by lmh on 2019/7/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_SearchHeaderView.h"

@implementation C_SearchHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = UIColorFromRGBA(0x000000, 0.3);
    }
    return self;
}

- (void)createUI
{
    self.cityButton = [JSFactory creatButtonWithTitle:@"全部区域" textFont:font750(26) titleColor:Color_Black_464646 backGroundColor:Color_Gray_828282];
    self.distanceButton = [JSFactory creatButtonWithTitle:@"离我最近" textFont:font750(26) titleColor:Color_Black_464646 backGroundColor:Color_Gray_828282];
    self.lineView = [JSFactory createLineView];
    self.leftTableView = [JSFactory creatTabbleViewWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.rightTableView = [JSFactory creatTabbleViewWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    [self addSubview:self.cityButton];
    [self addSubview:self.distanceButton];
    [self addSubview:self.lineView];
    [self addSubview:self.leftTableView];
    [self addSubview:self.rightTableView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.height.equalTo(@(Anno750(73)));
        make.width.equalTo(@(Anno750(224)));
    }];
    [self.distanceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cityButton.mas_right);
        make.top.equalTo(@(0));
        make.height.equalTo(@(Anno750(73)));
        make.width.equalTo(@(Anno750(224)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.cityButton.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(self.lineView.mas_bottom);
        make.width.equalTo(@(Anno750(224)));
        make.height.equalTo(@(Anno750(480)));
    }];
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTableView.mas_right);
        make.top.equalTo(self.leftTableView);
        make.right.equalTo(@0);
        make.height.equalTo(self.leftTableView);
    }];
}

@end
