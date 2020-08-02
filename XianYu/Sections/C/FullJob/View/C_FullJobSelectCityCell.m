
//
//  C_FullJobSelectCityCell.m
//  XianYu
//
//  Created by lmh on 2019/7/14.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJobSelectCityCell.h"

@implementation C_FullJobSelectCityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.lineView.backgroundColor = Color_Blue_32A060;
        self.backgroundColor = Color_White;
    }
    else
    {
        self.lineView.backgroundColor = Color_Ground_F5F5F5;
        self.backgroundColor = Color_Ground_F5F5F5;
    }

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
    self.lineView = [JSFactory creatViewWithColor:Color_Blue_32A060];
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Gray_828282 textFont:font750(28) textAlignment:(NSTextAlignmentRight)];
    self.bottomLineView = [JSFactory createLineView];
    [self addSubview:self.lineView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.bottomLineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(8)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(self.lineView.mas_right).offset(Anno750(50));
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}

- (void)remarkNameLabel
{
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.equalTo(@(Anno750(20)));
        make.right.equalTo(@(-Anno750(20)));
    }];
}



@end
