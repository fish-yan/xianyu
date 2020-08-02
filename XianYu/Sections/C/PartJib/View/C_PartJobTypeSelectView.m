//
//  C_PartJobTypeSelectView.m
//  XianYu
//
//  Created by lmh on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_PartJobTypeSelectView.h"

@implementation C_PartJobTypeSelectView

- (RACSubject *)clickSubject
{
    if (!_clickSubject) {
        self.clickSubject = [RACSubject subject];
    }
    return _clickSubject;
}

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
    self.modifyButton = [JSFactory creatButtonWithTitle:@"筛选" textFont:font750(28) titleColor:Color_Gray_828282 backGroundColor:Color_White];
    [self.modifyButton setImage:GetImage(@"icon_c_fulljob_modify_job") forState:(UIControlStateNormal)];
    [self.modifyButton layoutButtonWithImageStyle:(ZJButtonImageStyleLeft) imageTitleToSpace:Anno750(3)];
    self.scrollView = [[UIScrollView alloc]initWithFrame:(CGRectZero)];
    self.bottomLineView = [JSFactory createLineView];
    self.areaButton = [JSFactory creatButtonWithTitle:@"全部区域" textFont:font750(26) titleColor:Color_Gray_828282 backGroundColor:Color_White];
    [self.areaButton setImage:GetImage(@"icon_c_fulljob_down") forState:(UIControlStateNormal)];
    self.typeButton = [JSFactory creatButtonWithTitle:@"结算方式不限" textFont:font750(26) titleColor:Color_Gray_828282 backGroundColor:Color_White];
    [self.typeButton setImage:GetImage(@"icon_c_fulljob_down") forState:(UIControlStateNormal)];
    self.paixunButton = [JSFactory creatButtonWithTitle:@"距离最近" textFont:font750(26) titleColor:Color_Gray_828282 backGroundColor:Color_White];
    [self.paixunButton setImage:GetImage(@"icon_c_fulljob_down") forState:(UIControlStateNormal)];
    self.lineView = [JSFactory createLineView];
    [self addSubview:self.modifyButton];
    [self addSubview:self.scrollView];
    [self addSubview:self.bottomLineView];
    [self addSubview:self.areaButton];
    [self addSubview:self.paixunButton];
    [self addSubview:self.typeButton];
    
    [self addSubview:self.lineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.modifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(Anno750(75)));
        make.width.equalTo(@(Anno750(140)));
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(self.modifyButton);
        make.right.equalTo(self.modifyButton.mas_left).offset(-Anno750(20));
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self.scrollView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    [self.areaButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(@0);
        make.top.equalTo(self.bottomLineView.mas_bottom);
        make.width.equalTo(@(KScreenWidth/3.0));
    }];
    [self.paixunButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(@0);
        make.top.equalTo(self.areaButton);
        make.width.equalTo(self.areaButton);
    }];
    [self.typeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.areaButton.mas_right);
        make.right.equalTo(self.paixunButton.mas_left);
        make.top.bottom.equalTo(self.areaButton);
    }];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    [self.areaButton layoutButtonWithImageStyle:(ZJButtonImageStyleRight) imageTitleToSpace:Anno750(5)];
    [self.typeButton layoutButtonWithImageStyle:(ZJButtonImageStyleRight) imageTitleToSpace:Anno750(5)];
    [self.paixunButton layoutButtonWithImageStyle:(ZJButtonImageStyleRight) imageTitleToSpace:Anno750(5)];
}

- (void)createJobItemViewWithArray:(NSArray *)array;
{
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    UIButton *lastButton = nil;
    CGFloat button_x = 0;
    CGFloat button_y = 0;
    CGFloat button_w = 0;
    CGFloat button_h = Anno750(70);
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dict = array[i];
        NSString *nameStr = dict[@"name"];
        CGSize size = [JSFactory getSize:nameStr maxSize:(CGSizeMake(CGFLOAT_MAX, Anno750(70))) font:[UIFont systemFontOfSize:font750(30)]];
        button_w = size.width +Anno750(32);
        if (i == 0) {
            button_x = Anno750(16);
        }
        else
        {
            button_x = CGRectGetMaxX(lastButton.frame);
        }
        
        UIButton *button = [JSFactory creatButtonWithTitle:nameStr textFont:font750(30) titleColor:Color_Black_323232 backGroundColor:Color_White];
        button.frame = CGRectMake(button_x, button_y, button_w, button_h);
        button.tag = 3000 + i;
        if (i == 0) {
            [button setTitleColor:Color_Blue_32A060 forState:(UIControlStateNormal)];
        }
        [button addTarget:self action:@selector(clickJobTypeWithIndex:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.scrollView addSubview:button];
        lastButton = button;
    }
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastButton.frame), Anno750(70));
}


- (void)clickJobTypeWithIndex:(UIButton *)sender
{
    
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitleColor:Color_Black_323232 forState:(UIControlStateNormal)];
        }
    }
    [sender setTitleColor:Color_Blue_32A060 forState:(UIControlStateNormal)];
    if (self.clickSubject) {
        [self.clickSubject sendNext:@(sender.tag - 3000)];
    }
}

@end
