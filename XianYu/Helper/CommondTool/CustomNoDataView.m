//
//  CustomNoDataView.m
//  YouShang
//
//  Created by lmh on 2018/4/27.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "CustomNoDataView.h"

@implementation CustomNoDataView

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
        self.backgroundColor = Color_Line_EBEBEB;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.promptImageView = [JSFactory creatImageViewWithImageName:@""];
    self.contentLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_878787 textFont:font750(28) textAlignment:(NSTextAlignmentCenter)];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.promptImageView];
    [self addSubview:self.contentLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.promptImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@(-Anno750(100) - AppStatusBar - 44));
        make.size.mas_equalTo(CGSizeMake(Anno750(220), Anno750(220)));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.promptImageView.mas_bottom).offset(Anno750(20));
    }];
}


@end
