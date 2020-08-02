//
//  C_FullJobSelectButtonView.m
//  XianYu
//
//  Created by lmh on 2019/7/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJobSelectButtonView.h"

@implementation C_FullJobSelectButtonView

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
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.bottomLineView = [JSFactory createLineView];
    [self addSubview:self.modifyButton];
    [self addSubview:self.scrollView];
    [self addSubview:self.bottomLineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.modifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(140)));
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.bottom.equalTo(@0);
        make.right.equalTo(self.modifyButton.mas_left).offset(-Anno750(20));
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}

- (void)createJobItemViewWithArray:(NSArray *)array;
{
    NSLog(@"-------------");
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
        JobTypeModel *model = array[i];
        CGSize size = [JSFactory getSize:model.name maxSize:(CGSizeMake(CGFLOAT_MAX, Anno750(70))) font:[UIFont systemFontOfSize:font750(30)]];
        button_w = size.width +Anno750(32);
        if (i == 0) {
            button_x = Anno750(16);
        }
        else
        {
            button_x = CGRectGetMaxX(lastButton.frame);
        }
        
        UIButton *button = [JSFactory creatButtonWithTitle:model.name textFont:font750(30) titleColor:Color_Black_323232 backGroundColor:Color_White];
        if (i == 0) {
            [button setTitleColor:Color_Blue_32A060 forState:(UIControlStateNormal)];
        }
        button.frame = CGRectMake(button_x, button_y, button_w, button_h);
        button.tag = 3000 + i;
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
