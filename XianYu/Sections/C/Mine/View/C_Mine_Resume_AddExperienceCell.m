//
//  C_Mine_Resume_AddExperienceCell.m
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_Resume_AddExperienceCell.h"

@implementation C_Mine_Resume_AddExperienceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = Color_White;
        
    }
    return self;
}

- (void)createUI
{
    self.backView = [JSFactory creatViewWithColor:Color_White];
    self.addImaegView = [JSFactory creatImageViewWithImageName:@""];
    self.summaryLabel = [JSFactory creatLabelWithTitle:@"添加您的工作经历相关信息" textColor:Color_Black_A5A5A5 textFont:font750(28) textAlignment:(NSTextAlignmentCenter)];
    [self addSubview:self.backView];
    [self.backView addSubview:self.addImaegView];
    [self.backView addSubview:self.summaryLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.bottom.equalTo(@(-Anno750(10)));
        make.top.equalTo(@(Anno750(10)));
    }];
    [self.addImaegView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView).offset(Anno750(40));
        make.size.mas_equalTo(CGSizeMake(Anno750(60), Anno750(60)));
    }];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.addImaegView.mas_bottom).offset(Anno750(15));
        make.height.equalTo(@(Anno750(40)));
    }];
}

@end
