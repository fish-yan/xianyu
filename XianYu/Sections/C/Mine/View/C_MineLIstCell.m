//
//  C_MineLIstCell.m
//  XianYu
//
//  Created by lmh on 2019/7/3.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_MineLIstCell.h"

@implementation C_MineLIstCell

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
    self.leftImageView = [JSFactory creatImageViewWithImageName:@""];
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_464646 textFont:font750(34) textAlignment:(NSTextAlignmentLeft)];
    self.arrowImageView = [JSFactory createArrowImageView];
    self.lineView = [JSFactory createLineView];
    self.progressLab = [JSFactory creatLabelWithTitle:@"" textColor:Color_Blue_32A060 textFont:font750(24) textAlignment:(NSTextAlignmentCenter)];
    self.progressLab.layer.borderWidth = Anno750(2);
    self.progressLab.layer.borderColor = Color_Blue_32A060.CGColor;
    self.progressLab.layer.cornerRadius = Anno750(24);
    self.progressLab.hidden = YES;
    [self addSubview:self.leftImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.lineView];
    [self addSubview:self.progressLab];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(Anno750(40), Anno750(40)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(self.leftImageView.mas_right).offset(Anno750(30));
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@(-Anno750(24)));
        make.size.mas_equalTo(CGSizeMake(Anno750(28), Anno750(28)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@(0.5));
    }];
    [self.progressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.mas_left).offset(Anno750(-10));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(48)));
        make.width.equalTo(@(Anno750(190)));
    }];
}

- (void)configureWithImageStr:(NSString *)imageStr withNameStr:(NSString *)nameStr
{
    self.leftImageView.image = GetImage(imageStr);
    self.nameLabel.text = nameStr;
}


@end
