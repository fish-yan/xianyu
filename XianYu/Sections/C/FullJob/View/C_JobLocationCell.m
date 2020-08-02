//
//  C_JobLocationCell.m
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_JobLocationCell.h"

@implementation C_JobLocationCell

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
    self.nameLabel = [JSFactory creatLabelWithTitle:@"工作地址" textColor:Color_Black_464646 textFont:font750(40) textAlignment:(NSTextAlignmentLeft)];
    self.companyLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Gray_828282 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.rangeLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_A5A5A5 textFont:font750(26) textAlignment:(NSTextAlignmentRight)];
    self.userImageView = [JSFactory creatImageViewWithImageName:@"icon_b_job_map"];

    [JSFactory configureWithView:self.userImageView cornerRadius:Anno750(6) isBorder:NO borderWidth:0 borderColor:nil];
    self.addressLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    [self addSubview:self.nameLabel];
    [self addSubview:self.companyLabel];
    [self addSubview:self.rangeLabel];
    [self addSubview:self.userImageView];
    [self addSubview:self.addressLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(44)));
        make.top.equalTo(@(Anno750(30)));
        make.height.equalTo(@(Anno750(56)));
    }];
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(Anno750(13));
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.rangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(44)));
        make.centerY.equalTo(self.companyLabel);
    }];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rangeLabel);
        make.top.equalTo(self.companyLabel.mas_bottom).offset(Anno750(20));
        make.size.mas_equalTo(CGSizeMake(Anno750(216), Anno750(126)));
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.userImageView);
        make.right.equalTo(self.userImageView.mas_left).offset(-Anno750(20));
    }];
}

- (void)configureWithModel:(C_FullJobDetailModel *)model
{
    self.companyLabel.text = model.shopname;
    self.addressLabel.numberOfLines = 0;
    [self.addressLabel setstring:model.address lineSpace:Anno750(12) isAlign:(NSTextAlignmentLeft)];
    self.rangeLabel.text = model.juli;
}

- (void)configureWithPartJobModel:(C_PartJobInfoDetailModel *)model
{
    self.companyLabel.text = model.shopname;
    self.addressLabel.numberOfLines = 0;
    [self.addressLabel setstring:model.address lineSpace:Anno750(12) isAlign:(NSTextAlignmentLeft)];
    self.rangeLabel.text = model.juli;
}

@end
