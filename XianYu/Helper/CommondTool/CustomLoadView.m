//
//  CustomLoadView.m
//  YouShang
//
//  Created by lmh on 2018/4/27.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "CustomLoadView.h"

@implementation CustomLoadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGB(0xdddddd);
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.animatedImageView = [[FLAnimatedImageView alloc]initWithFrame:(CGRectZero)];
    self.animatedImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.animatedImageView.clipsToBounds = YES;
//    self.animatedImageView.runLoopMode = NSRunLoopCommonModes;
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"icon_loading" withExtension:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
    self.animatedImageView.animatedImage = animatedImage1;

//    self.contentLabel = [JSFactory creatLabelWithTitle:@"正在查询中,请稍候...." textColor:Color_Gray_878787 textFont:font750(30) textAlignment:(NSTextAlignmentCenter)];
    [self addSubview:self.animatedImageView];
//    [self addSubview:self.contentLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.animatedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@(140 + NavRectHeight));
        make.size.mas_equalTo(CGSizeMake(Anno750(160), Anno750(160)));
    }];
//    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(Anno750(45)));
//        make.right.equalTo(@(-Anno750(45)));
//        make.height.equalTo(@(50));
//        make.top.equalTo(self.animatedImageView.mas_bottom).offset(Anno750(20));
//    }];
    
}

@end
