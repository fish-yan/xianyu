//
//  C_PartJobSelectCell.m
//  XianYu
//
//  Created by lmh on 2019/7/7.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_PartJobSelectCell.h"

@implementation C_PartJobSelectCell

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
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_A5A5A5 textFont:font750(28) textAlignment:(NSTextAlignmentCenter)];
    self.nameLabel.backgroundColor = Color_Ground_F5F5F5;
    [JSFactory configureWithView:self.nameLabel cornerRadius:Anno750(3) isBorder:NO borderWidth:0 borderColor:nil];
    [self addSubview:self.nameLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

@end
