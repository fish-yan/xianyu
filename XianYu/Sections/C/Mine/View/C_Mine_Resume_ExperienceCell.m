//
//  C_Mine_Resume_ExperienceCell.m
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_Resume_ExperienceCell.h"

@implementation C_Mine_Resume_ExperienceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

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
    self.timeLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Gray_828282 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.summaryLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    self.companyLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Gray_828282 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    [self addSubview:self.backView];
    [self.backView addSubview:self.timeLabel];
    [self.backView addSubview:self.summaryLabel];
    [self.backView addSubview:self.companyLabel];
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
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(Anno750(32));
        make.top.equalTo(self.backView).offset(Anno750(26));
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(Anno750(9));
        make.height.equalTo(@(Anno750(42)));
    }];
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel);
        make.top.equalTo(self.summaryLabel.mas_bottom).offset(Anno750(8));
        make.height.equalTo(@(Anno750(40)));
    }];
}

- (void)configureWithModel:(id)model
{
    self.timeLabel.text = @"2019.01-2019.06";
    self.summaryLabel.text = @"全职 | 服务员";
    self.companyLabel.text = @"上海嘻嘻嘻餐饮有限公司";
}

@end
