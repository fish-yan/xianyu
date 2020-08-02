//
//  C_Mine_EditUserInfoListCell.m
//  XianYu
//
//  Created by lmh on 2019/7/3.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_EditUserInfoListCell.h"

@implementation C_Mine_EditUserInfoListCell

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
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    self.rightImageView = [JSFactory createArrowImageView];
    self.summaryLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(30) textAlignment:(NSTextAlignmentRight)];
    self.userImageView = [JSFactory creatImageViewWithImageName:nil];
    [JSFactory configureWithView:self.userImageView cornerRadius:Anno750(35) isBorder:NO borderWidth:0 borderColor:nil];
    self.userImageView.backgroundColor = Color_Gray_828282;
    [self addSubview:self.nameLabel];
    [self addSubview:self.rightImageView];
    [self addSubview:self.summaryLabel];
    [self addSubview:self.userImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@(Anno750(24)));
    }];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(Anno750(28), Anno750(28)));
    }];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(self.rightImageView.mas_left).offset(-Anno750(26));
    }];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
//        make.size.mas_equalTo(CGSizeMake(Anno750(70), Anno750(70));
        make.size.mas_equalTo(CGSizeMake(Anno750(70), Anno750(70)));
    }];
}

@end
