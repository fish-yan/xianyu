//
//  C_JobInfoCell.m
//  XianYu
//
//  Created by lmh on 2019/6/27.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_JobInfoCell.h"

@implementation C_JobInfoCell

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
    self.titleLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_464646 textFont:font750(48) textAlignment:(NSTextAlignmentLeft)];
    self.markLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Green_288fFE textFont:font750(20) textAlignment:(NSTextAlignmentCenter)];
    
    [JSFactory configureWithView:self.markLabel cornerRadius:Anno750(3) isBorder:YES borderWidth:0.5 borderColor:Color_Green_288fFE];
    
    self.markLabel1 = [JSFactory creatLabelWithTitle:@"" textColor:Color_Green_288fFE textFont:font750(20) textAlignment:(NSTextAlignmentCenter)];
    [JSFactory configureWithView:self.markLabel1 cornerRadius:Anno750(3) isBorder:YES borderWidth:0.5 borderColor:Color_Green_288fFE];
    self.markLabel1.hidden = YES;
    self.moneyLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Orange_FF794F textFont:font750(40) textAlignment:(NSTextAlignmentLeft)];
    self.ageLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    self.genderLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    self.jobYearLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    self.lineView = [JSFactory createLineView];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.markLabel];
    [self addSubview:self.markLabel1];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.jobYearLabel];
    [self addSubview:self.ageLabel];
    [self addSubview:self.genderLabel];
    [self addSubview:self.lineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(44)));
        make.top.equalTo(@(Anno750(41)));
        make.height.equalTo(@(Anno750(67)));
    }];
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(Anno750(20));
        make.size.mas_equalTo(CGSizeMake(Anno750(80), Anno750(32)));
        make.centerY.equalTo(self.titleLabel);
    }];
    [self.markLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.markLabel.mas_right).offset(Anno750(10));
        make.size.mas_equalTo(CGSizeMake(Anno750(100), Anno750(32)));
        make.centerY.equalTo(self.titleLabel);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(44)));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Anno750(15));
        make.height.equalTo(@(Anno750(56)));
    }];
    [self.jobYearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-Anno750(40)));
        make.left.equalTo(@(Anno750(44)));
        make.height.equalTo(@(Anno750(52)));
    }];
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jobYearLabel);
        make.height.equalTo(self.jobYearLabel);
        make.bottom.equalTo(self.jobYearLabel.mas_top).offset(-Anno750(10));
    }];
    [self.genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(44)));
        make.centerY.height.equalTo(self.ageLabel);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
}

- (void)configureWithModel:(C_FullJobDetailModel *)model
{
    if (model.jobname && model.jobname.length != 0) {
        self.titleLabel.text = model.jobname;
    } else {
        self.titleLabel.text = model.classname;
    }
    if (model.jobtype == 0) {
        self.markLabel.text = @"全职";
    }
    else if (model.jobtype == 1)
    {
        self.markLabel.text = @"兼职";
    }
    
    self.moneyLabel.text = model.wagedes;
    self.jobYearLabel.text = [NSString stringWithFormat:@"经验要求：%@", model.jobexp];
    self.ageLabel.text = [NSString stringWithFormat:@"年龄要求：%@", model.age];
    self.genderLabel.text = [NSString stringWithFormat:@" 学历要求：%@", model.educationname];
    [self createWealfareLabelView:model.welfare];
}

- (void)configureWithPartJobModel:(C_PartJobInfoDetailModel *)model
{
    self.markLabel1.hidden = NO;
    if (model.jobname && model.jobname.length != 0) {
        self.titleLabel.text = model.jobname;
    } else {
        self.titleLabel.text = model.classname;
    }
    if (model.jobtype == 0) {
        self.markLabel.text = @"全职";
    }
    else if (model.jobtype == 1)
    {
        self.markLabel.text = @"兼职";
    }
    
    if (model.wagetype == 0) {
        self.markLabel1.text = @"日结";
    }
    else if (model.wagetype == 1)
    {
        self.markLabel1.text = @"周结";
    }
    else if (model.wagetype == 2)
    {
        self.markLabel1.text = @"月结";
    }
    else if (model.wagetype == 3)
    {
        self.markLabel1.text = @"完工结";
    }
    
    self.moneyLabel.text = model.wagedes;
    self.jobYearLabel.text = [NSString stringWithFormat:@"经验要求：%@", model.jobexp];
    self.ageLabel.text = [NSString stringWithFormat:@"年龄要求：%@", model.age];
    self.genderLabel.text = [NSString stringWithFormat:@" 学历要求：%@", model.educationname];
    [self createWealfareLabelView:model.welfare];
}



- (CGFloat)createWealfareLabelView:(NSArray *)array
{
    
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]] && view.tag >= 5000) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat ori_x = Anno750(44);
    CGFloat ori_y = Anno750(221);
    CGFloat ori_h = Anno750(47);
    CGFloat label_x = 0;
    CGFloat label_y = 0;
    CGFloat label_h = 0;
    CGFloat label_w = 0;
    
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
            if (CGRectGetMaxX(lastLabel.frame) + Anno750(11) + Anno750(33) > KScreenWidth) {
                label_x = ori_x;
                label_y = CGRectGetMaxY(lastLabel.frame) + Anno750(20);
                label_w = size.width + Anno750(36);
                label_h = ori_h;
            }
            else
            {
                label_x = CGRectGetMaxX(lastLabel.frame) + Anno750(11);
                label_y = CGRectGetMinY(lastLabel.frame);
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
    return  CGRectGetMaxY(lastLabel.frame) + Anno750(57);
    
}


@end
