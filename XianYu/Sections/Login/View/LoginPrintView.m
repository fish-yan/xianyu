//
//  LoginPrintView.m
//  XianYu
//
//  Created by lmh on 2019/6/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "LoginPrintView.h"

@implementation LoginPrintView

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
    self.printField = [JSFactory creatTextFieldWithPlaceHolder:nil textAlignment:(NSTextAlignmentLeft) textColor:[UIColor blackColor] textFont:font750(40)];
    self.lineView = [JSFactory createLineView];
    [self addSubview:self.printField];
    [self addSubview:self.lineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.printField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@(0.5));
    }];
}

@end
