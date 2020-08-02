//
//  C_Mine_ResumeStatusCell.m
//  XianYu
//
//  Created by lmh on 2019/7/7.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_ResumeStatusCell.h"

@implementation C_Mine_ResumeStatusCell

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
    self.jobStatusLabel = [JSFactory creatLabelWithTitle:@"求职状态" textColor:Color_Black_464646 textFont:font750(34) textAlignment:(NSTextAlignmentLeft)];
    self.arrow = [JSFactory createArrowImageView];
    self.summaryLabel = [JSFactory creatLabelWithTitle:@"随便看看" textColor:Color_Gray_828282 textFont:font750(30) textAlignment:(NSTextAlignmentRight)];
    [self addSubview:self.jobStatusLabel];
    [self addSubview:self.arrow];
    [self addSubview:self.summaryLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.jobStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(25)));
        make.centerY.equalTo(@0);
    }];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(28)));
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(Anno750(28), Anno750(28)));
    }];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(self.arrow.mas_left).offset(-Anno750(16));
    }];
}

@end
