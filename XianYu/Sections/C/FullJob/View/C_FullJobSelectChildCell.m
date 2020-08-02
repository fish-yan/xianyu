//
//  C_FullJobSelectChildCell.m
//  XianYu
//
//  Created by lmh on 2019/7/14.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJobSelectChildCell.h"

@implementation C_FullJobSelectChildCell

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
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Gray_828282 textFont:font750(24) textAlignment:(NSTextAlignmentLeft)];
    self.rightIamgeView = [JSFactory creatImageViewWithImageName:@"icon_c_fulljob_city_select"];
    [self addSubview:self.nameLabel];
    [self addSubview:self.rightIamgeView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(41)));
        make.centerY.equalTo(@0);
    }];
    [self.rightIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(Anno750(27));
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(Anno750(22), Anno750(22)));
    }];
}

@end
