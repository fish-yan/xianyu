

//
//  B_News_ResumeView.m
//  XianYu
//
//  Created by lmh on 2019/7/30.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "B_News_ResumeView.h"

@implementation B_News_ResumeView

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
    self.jobLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.arrowImageView = [JSFactory createArrowImageView];
    self.lineView = [JSFactory createLineView];
    self.photoImageView = [JSFactory creatImageViewWithImageName:nil];
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    self.statusLabel = [JSFactory creatLabelWithTitle:@"" textColor:UIColorFromRGB(0xF53C3C) textFont:font750(28) textAlignment:(NSTextAlignmentRight)];
    self.statusLabel.hidden = YES;
    self.nameLabel.font = [UIFont boldSystemFontOfSize:font750(30)];
    self.infoLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Gray_828282 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.bottomImageView = [JSFactory createArrowImageView];
    self.bottomImageView.hidden = YES;
    self.wantJobLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    self.jobStatusLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    self.jobButton = [JSFactory creatButtonWithNormalImage:nil selectImage:nil];
    self.clickButton = [JSFactory creatButtonWithNormalImage:nil selectImage:nil];
    [self addSubview:self.jobLabel];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.lineView];
    [self addSubview:self.photoImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.statusLabel];
    [self addSubview:self.infoLabel];
    [self addSubview:self.wantJobLabel];
    [self addSubview:self.jobStatusLabel];
    [self addSubview:self.bottomImageView];
    [self addSubview:self.jobButton];
    [self addSubview:self.clickButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.jobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(22)));
        make.top.equalTo(@(Anno750(20)));
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(22)));
        make.centerY.equalTo(self.jobLabel);
        make.size.mas_equalTo(CGSizeMake(Anno750(28), Anno750(28)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@(Anno750(78)));
        make.height.equalTo(@0.5);
    }];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jobLabel);
        make.top.equalTo(self.lineView.mas_bottom).offset(Anno750(20));
        make.size.mas_equalTo(CGSizeMake(Anno750(100), Anno750(100)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photoImageView.mas_right).offset(Anno750(18));
        make.top.equalTo(self.photoImageView);
        make.height.equalTo(@(Anno750(42)));
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView);
        make.centerY.equalTo(self.nameLabel);
    }];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.photoImageView);
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.wantJobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jobLabel);
        make.height.equalTo(@(Anno750(42)));
        make.top.equalTo(self.photoImageView.mas_bottom).offset(Anno750(25));
    }];
    [self.jobStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jobLabel);
        make.height.equalTo(@(Anno750(42)));
        make.top.equalTo(self.wantJobLabel.mas_bottom).offset(Anno750(16));
    }];
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView);
        make.top.equalTo(self.photoImageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(Anno750(28), Anno750(28)));
    }];
    [self.jobButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.bottom.equalTo(self.lineView);
    }];
    [self.clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
        make.top.equalTo(self.jobButton.mas_bottom);
    }];
}

- (void)configureWithModel:(B_News_ResumeModel *)model with:(C_News_JobInfoModel *)jobModel
{
    self.jobLabel.text = jobModel.classname;
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
    self.nameLabel.text = model.name;
    self.infoLabel.text = [NSString stringWithFormat:@"%@ | %@ | %@", model.sex, model.educationname, model.jobexp];
//    if (model.shopsee == 0) {
//        self.statusLabel.text = @"未查看";
//    }
//    else
//    {
//        self.statusLabel.text = @"已查看";
//    }
    self.jobStatusLabel.text = [NSString stringWithFormat:@"当前状态：%@", model.jobstatus];
    NSArray *array = [model.wantjob componentsSeparatedByString:@"&"];
    [self createViewLabelWithArray:array];
}


- (void)createViewLabelWithArray:(NSArray *)array
{
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]] && view.tag >= 5000) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat ori_x = Anno750(175);
    CGFloat ori_y = Anno750(219);
    CGFloat ori_h = Anno750(52);
    CGFloat label_x = 0;
    CGFloat label_y = 0;
    CGFloat label_h = 0;
    CGFloat label_w = 0;
    
    UILabel *lastLabel = nil;
    for (int i = 0; i < array.count; i++) {
        NSString *str = array[i];
        CGSize size = [JSFactory getSize:str maxSize:(CGSizeMake(CGFLOAT_MAX, ori_h)) font:[UIFont systemFontOfSize:Anno750(26)]];
        if (i == 0) {
            label_x = ori_x;
            label_y = ori_y;
            label_h = ori_h;
            label_w = size.width + Anno750(40);
        }
        else
        {
            label_w = size.width + Anno750(40);
            if (CGRectGetMaxX(lastLabel.frame) + Anno750(20) + label_w + Anno750(68) > KScreenWidth) {
                continue;
            }
            else
            {
                label_x = CGRectGetMaxX(lastLabel.frame) + Anno750(20);
                label_y = ori_y;
                label_h = ori_h;
                label_w = size.width + Anno750(40);
            }
        }
        UILabel *label = [JSFactory creatLabelWithTitle:str textColor:Color_Green_2886FE textFont:font750(24) textAlignment:(NSTextAlignmentCenter)];
        label.tag = 5000 + i;
        label.frame = CGRectMake(label_x, label_y, label_w, label_h);
        label.frame = CGRectIntegral(label.frame);
        [JSFactory configureWithView:label cornerRadius:Anno750(3) isBorder:NO borderWidth:0 borderColor:nil];
        label.backgroundColor = Color_Green_E9F3FF;
        [self addSubview:label];
        lastLabel = label;
    }
}

@end
