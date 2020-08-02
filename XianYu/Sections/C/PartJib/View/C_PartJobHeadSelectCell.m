//
//  C_PartJobHeadSelectCell.m
//  XianYu
//
//  Created by lmh on 2019/7/22.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_PartJobHeadSelectCell.h"

@implementation C_PartJobHeadSelectCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected) {
//        self.arrawImageView.hidden = NO;
//    }
//    else
//    {
//        self.arrawImageView.hidden = YES;
//    }
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
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Gray_828282 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.arrawImageView = [JSFactory creatImageViewWithImageName:@"icon_c_fulljob_city_select"];
    self.lineView = [JSFactory createLineView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.arrawImageView];
    [self addSubview:self.lineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(60)));
        make.centerY.equalTo(@0);
    }];
    [self.arrawImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(Anno750(30));
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(Anno750(22), Anno750(22)));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}

@end
