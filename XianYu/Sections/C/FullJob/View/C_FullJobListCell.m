//
//  C_FullJobListCell.m
//  XianYu
//
//  Created by lmh on 2019/6/24.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJobListCell.h"

@implementation C_FullJobListCell

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
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(32) textAlignment:(NSTextAlignmentLeft)];
    self.moneyLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Orange_FF794F textFont:font750(30) textAlignment:(NSTextAlignmentRight)];
    self.logoImageView = [JSFactory creatImageViewWithImageName:@""];
    self.logoImageView.hidden = YES;
    self.logoImageView.backgroundColor = Color_Gray_828282;
    self.companyLabe = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_464646 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    [JSFactory configureWithView:self.logoImageView cornerRadius:Anno750(3) isBorder:NO borderWidth:0 borderColor:nil];
    self.locationLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_878787 textFont:font750(28) textAlignment:(NSTextAlignmentRight)];
    self.clickButton = [JSFactory creatButtonWithTitle:@"沟通一下" textFont:font750(28) titleColor:Color_Blue_32A060 backGroundColor:UIColorFromRGB(0xEFF7F2)];
    [JSFactory configureWithView:self.clickButton cornerRadius:Anno750(6) isBorder:YES borderWidth:0.5 borderColor:Color_Blue_32A060];
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = Color_Ground_F5F5F5;
    [self addSubview:self.nameLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.logoImageView];
    [self addSubview:self.companyLabe];
    [self addSubview:self.locationLabel];
    [self addSubview:self.clickButton];
    [self addSubview:self.bottomView];
    
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(33)));
        make.top.equalTo(@(Anno750(25)));
        make.height.equalTo(@(Anno750(45)));
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(33)));
        make.centerY.equalTo(self.nameLabel);
        make.right.equalTo(@(Anno750(42)));
    }];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(33)));
        make.bottom.equalTo(@(-Anno750(72)));
        make.size.mas_equalTo(CGSizeMake(Anno750(83), Anno750(83)));
    }];
    [self.companyLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(33)));
        make.centerY.equalTo(self.logoImageView);
    }];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(33)));
        make.top.equalTo(self.logoImageView);
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(33)));
        make.bottom.equalTo(@(-Anno750(42)));
        make.size.mas_equalTo(CGSizeMake(Anno750(146), Anno750(63)));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@10);
        
    }];
    
}

- (void)createWealfareLabelView:(NSArray *)array
{
    
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]] && view.tag >= 5000) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat ori_x = Anno750(33);
    CGFloat ori_y = Anno750(93);
    CGFloat ori_h = Anno750(47);
    CGFloat label_x = 0;
    CGFloat label_y = 0;
    CGFloat label_h = 0;
    CGFloat label_w = 0;
    
    CGFloat ori_w = 0;
    UILabel *lastLabel = nil;
    for (int i = 0; i < array.count; i++) {
        NSString *str = array[i];
        CGSize size = [JSFactory getSize:str maxSize:(CGSizeMake(CGFLOAT_MAX, ori_h)) font:[UIFont systemFontOfSize:Anno750(24)]];
        if (i == 0) {
            label_x = ori_x;
            label_y = ori_y;
            label_h = ori_h;
            label_w = size.width + Anno750(36);
        }
        else
        {
            label_w = size.width + Anno750(36);
            if (CGRectGetMaxX(lastLabel.frame) + Anno750(11) + label_w + Anno750(33) > KScreenWidth) {
                continue;
            }
            else
            {
                label_x = CGRectGetMaxX(lastLabel.frame) + Anno750(11);
                label_y = ori_y;
                label_h = ori_h;
                label_w = size.width + Anno750(36);
            }
        }
        UILabel *label = [JSFactory creatLabelWithTitle:str textColor:Color_Green_2886FE textFont:font750(24) textAlignment:(NSTextAlignmentCenter)];
        label.tag = 5000 + i;
        label.frame = CGRectMake(label_x, label_y, label_w, label_h);
        label.frame = CGRectIntegral(label.frame);
        [JSFactory configureWithView:label cornerRadius:Anno750(3) isBorder:NO borderWidth:0 borderColor:nil];
        label.backgroundColor = Color_Green_E9F3FF;
        [self addSubview:label];
        lastLabel = label;
    }
}


- (void)configureWithModel:(C_FullJobListModel *)model
{
    if (model.jobname && model.jobname.length != 0) {
        self.nameLabel.text = model.jobname;
    } else {
        self.nameLabel.text = model.classname;
    }
    self.moneyLabel.text = model.wagedes;
    self.companyLabe.text = model.shopname;
    self.locationLabel.text = model.juli;
    [self createWealfareLabelView:model.welfare];
    if (model.iscan == 0) {
        self.clickButton.hidden = NO;
    }
    else
    {
        self.clickButton.hidden = YES;
    }
}

@end
