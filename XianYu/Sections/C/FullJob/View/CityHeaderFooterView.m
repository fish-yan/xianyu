
//
//  CityHeaderFooterView.m
//  New_MeiChai
//
//  Created by lmh on 2018/6/7.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "CityHeaderFooterView.h"

@implementation CityHeaderFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = Color_White;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.backView = [JSFactory creatViewWithColor:Color_Ground_F5F5F5];
    self.headerLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_464646 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    
    
    
    [self addSubview:self.backView];
    [self addSubview:self.headerLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(@(-40));
    }];
    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
}

@end
