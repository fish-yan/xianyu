//
//  BindPhoneView.m
//  XianYu
//
//  Created by lmh on 2019/6/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BindPhoneView.h"

@implementation BindPhoneView

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
        self.backgroundColor = Color_White;
    }
    return self;
}

- (void)createUI
{
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    self.printField = [JSFactory creatTextFieldWithPlaceHolder:@"" textAlignment:(NSTextAlignmentLeft) textColor:Color_Black_323232 textFont:font750(30)];
    self.lineView = [JSFactory createLineView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.printField];
    [self addSubview:self.lineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(110)));
    }];
    [self.printField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(Anno750(58));
        make.top.bottom.equalTo(@0);
        make.right.equalTo(@(-Anno750(24)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}

@end
