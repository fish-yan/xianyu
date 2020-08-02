//
//  C_JobInfoListCell.m
//  XianYu
//
//  Created by lmh on 2019/7/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_JobInfoListCell.h"

@implementation C_JobInfoListCell

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
    self.jobLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(32) textAlignment:(NSTextAlignmentLeft)];
    self.moneyLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Orange_FF794F textFont:font750(30) textAlignment:(NSTextAlignmentRight)];
    self.logoImageView = [JSFactory creatImageViewWithImageName:@""];
    self.logoImageView.hidden = YES;
    self.companyLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_464646 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.rangeLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_878787 textFont:font750(28) textAlignment:(NSTextAlignmentRight)];
    self.lineView = [JSFactory createLineView];
    [self addSubview:self.jobLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.logoImageView];
    [self addSubview:self.companyLabel];
    [self addSubview:self.rangeLabel];
    [self addSubview:self.lineView];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.jobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(43)));
        make.top.equalTo(@(Anno750(25)));
        make.height.equalTo(@(Anno750(45)));
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(43)));
        make.centerY.equalTo(self.jobLabel);
    }];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(43)));
        make.bottom.equalTo(@(-Anno750(27)));
        make.size.mas_equalTo(CGSizeMake(Anno750(55), Anno750(55)));
    }];
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.logoImageView.mas_right).offset(Anno750(20));
        make.left.equalTo(@(Anno750(43)));
        make.centerY.equalTo(self.logoImageView);
    }];
    [self.rangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(43)));
        make.centerY.equalTo(self.logoImageView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
        make.height.equalTo(@(Anno750(10)));
    }];
}

- (void)configureWithModel:(C_PartJobListModel *)model
{
//    self.jobLabel.text = model.classname;
//    self.moneyLabel.text = model.wagedes;
//    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:GetImage(@"")];
//    self.companyLabel.text = model.shopname;
//    self.rangeLabel.text = model.juli;
//
//    [self createWealfareLabelView:mode.];
}

- (void)configureWithPartJobModel:(C_PartJobInfoListModel *)model
{
    if (model.jobname && model.jobname.length != 0) {
        self.jobLabel.text = model.jobname;
    } else {
        self.jobLabel.text = model.classname;
    }
    
    self.moneyLabel.text = model.wagedes;
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:GetImage(@"")];
    self.companyLabel.text = model.shopname;
    self.rangeLabel.text = model.juli;
    [self createWealfareLabelView:model.welfare];

}


- (void)createWealfareLabelView:(NSArray *)array
{
    
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]] && view.tag >= 5000) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat ori_x = Anno750(43);
    CGFloat ori_y = Anno750(92);
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


@end
