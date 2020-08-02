//
//  C_FullJob_DescribeCell.m
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJob_DescribeCell.h"

@implementation C_FullJob_DescribeCell

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
    self.nameLabel = [JSFactory creatLabelWithTitle:@"职位描述" textColor:Color_Black_464646 textFont:font750(40) textAlignment:(NSTextAlignmentLeft)];
    self.summaryLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Gray_828282 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.summaryLabel.numberOfLines = 0;
    self.lineView = [JSFactory createLineView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.summaryLabel];
    [self addSubview:self.lineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(44)));
        make.top.equalTo(@(Anno750(31)));
        make.height.equalTo(@(Anno750(56)));
    }];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(@(-Anno750(44)));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(Anno750(27));
        make.bottom.equalTo(@(-Anno750(20)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
}

@end
