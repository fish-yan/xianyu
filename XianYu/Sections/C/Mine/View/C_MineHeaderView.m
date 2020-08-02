//
//  C_MineHeaderView.m
//  XianYu
//
//  Created by lmh on 2019/7/3.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_MineHeaderView.h"

@implementation C_MineHeaderView

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
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_464646 textFont:font750(48) textAlignment:(NSTextAlignmentLeft)];
    self.summaryLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_878787 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.chateCountLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_878787 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.headImageView = [JSFactory creatImageViewWithImageName:@""];
    self.headImageView.backgroundColor = Color_Ground_F5F5F5;
    [JSFactory configureWithView:self.headImageView cornerRadius:Anno750(60) isBorder:NO borderWidth:0 borderColor:nil];
//    self.arrowImageView = [JSFactory createArrowImageView];
    self.clickButon = [JSFactory creatButtonWithNormalImage:nil selectImage:nil];
//    [self addSubview:self.arrowImageView];
    [self addSubview:self.headImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.summaryLabel];
    [self addSubview:self.chateCountLabel];
    [self addSubview:self.clickButon];
   
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(@(Anno750(20)));
//        make.right.equalTo(@(-Anno750(24)));
//        make.size.mas_equalTo(CGSizeMake(Anno750(28), Anno750(28)));
//    }];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.size.mas_equalTo(CGSizeMake(Anno750(120), Anno750(120)));
        make.centerY.equalTo(@(Anno750(20)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(self.headImageView.mas_top).offset(Anno750(-10));
        make.height.equalTo(@(Anno750(67)));
    }];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(3);
        make.left.equalTo(self.nameLabel);
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.chateCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.summaryLabel.mas_bottom).offset(3);
        make.left.equalTo(self.nameLabel);
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.clickButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

@end
