//
//  C_SearchHeadView.m
//  XianYu
//
//  Created by lmh on 2019/7/23.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_SearchHeadView.h"

@implementation C_SearchHeadView

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
    self.areaButton = [JSFactory creatButtonWithTitle:@"全部区域" textFont:font750(26) titleColor:Color_Gray_828282 backGroundColor:Color_White];
    [self.areaButton setImage:GetImage(@"icon_c_fulljob_down") forState:(UIControlStateNormal)];
    self.distanceButton = [JSFactory creatButtonWithTitle:@"离我最近" textFont:font750(26) titleColor:Color_Gray_828282 backGroundColor:Color_White];
    [self.distanceButton setImage:GetImage(@"icon_c_fulljob_down") forState:(UIControlStateNormal)];
    self.lineView = [JSFactory createLineView];
    [self addSubview:self.areaButton];
    [self addSubview:self.distanceButton];
    [self addSubview:self.lineView];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.areaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.width.equalTo(@(KScreenWidth/3.0));
    }];
    [self.distanceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(self.areaButton.mas_right);
        make.width.equalTo(@(KScreenWidth/3.0));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    [self.areaButton layoutButtonWithImageStyle:(ZJButtonImageStyleRight) imageTitleToSpace:Anno750(5)];
    [self.distanceButton layoutButtonWithImageStyle:(ZJButtonImageStyleRight) imageTitleToSpace:Anno750(5)];
}

@end
