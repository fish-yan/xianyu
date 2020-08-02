//
//  CustomErrorView.m
//  YouShang
//
//  Created by lmh on 2018/4/27.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "CustomErrorView.h"

@implementation CustomErrorView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame isError:(BOOL)isError
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_Ground_F5F5F5;
        self.errorImageView = [JSFactory creatImageViewWithImageName:@"icon_base_no_data"];

        self.errorLabel = [JSFactory creatLabelWithTitle:@"信息加载失败,请重试" textColor:Color_Black_A5A5A5 textFont:font750(28) textAlignment:(NSTextAlignmentCenter)];

        self.errorButton = [JSFactory creatButtonWithTitle:@"重新加载" textFont:font750(36) titleColor:Color_Black_878787 backGroundColor:nil];

//        [JSFactory configureWithView:self.errorButton cornerRadius:Anno750(6) isBorder:YES borderWidth:Anno750(2) borderColor:nil];
        if (isError) {
            self.errorImageView.image = GetImage(@"icon_base_no_data");
            self.errorLabel.text = @"信息加载失败,请重试";
        }
        else
        {
            self.errorImageView.image = GetImage(@"icon_base_no_data");
            self.errorLabel.text = @"信息加载失败,请重试";
        }
        [self addSubview:self.errorImageView];
        [self addSubview:self.errorLabel];
        [self addSubview:self.errorButton];
        [self.errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(@(-Anno750(75) - AppStatusBar - 44 - 30));
            if (isError) {
                make.size.mas_equalTo(CGSizeMake(Anno750(100), Anno750(100)));
            }
            else
            {
                make.size.mas_equalTo(CGSizeMake(Anno750(100), Anno750(100)));
            }
        }];
        [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(Anno750(45)));
            make.right.equalTo(@(-Anno750(45)));
            make.top.equalTo(self.errorImageView.mas_bottom).offset(Anno750(20));
        }];
        [self.errorButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.bottom.equalTo(@(- AppStatusBar - 44 - Anno750(150) - AppTabbarHeight));
            make.size.mas_equalTo(CGSizeMake(KScreenWidth - Anno750(200), Anno750(100)));
        }];
    }
    return self;
}


@end

