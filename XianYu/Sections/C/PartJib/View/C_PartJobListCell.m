//
//  C_PartJobListCell.m
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_PartJobListCell.h"

@implementation C_PartJobListCell

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
    self.markLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Green_2886FE textFont:font750(20) textAlignment:(NSTextAlignmentCenter)];
    [JSFactory configureWithView:self.markLabel cornerRadius:Anno750(4) isBorder:YES borderWidth:0.5 borderColor:Color_Green_2886FE];
    self.rangeLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_878787 textFont:font750(28) textAlignment:(NSTextAlignmentRight)];
    self.moneyLabel = [JSFactory creatLabelWithTitle:@"" textColor:UIColorFromRGB(0xFF794F) textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    self.logoIamgeView = [JSFactory creatImageViewWithImageName:nil];
    [JSFactory configureWithView:self.logoIamgeView cornerRadius:Anno750(3) isBorder:NO borderWidth:0 borderColor:nil];
    self.companyLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_464646 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.contractButton = [JSFactory creatButtonWithTitle:@"沟通一下" textFont:font750(28) titleColor:Color_Blue_32A060 backGroundColor:UIColorFromRGB(0xEFF7F2)];
    [JSFactory configureWithView:self.contractButton cornerRadius:Anno750(6) isBorder:YES borderWidth:0.5 borderColor:Color_Blue_32A060];
    [self addSubview:self.nameLabel];
    [self addSubview:self.markLabel];
    [self addSubview:self.rangeLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.logoIamgeView];
    [self addSubview:self.companyLabel];
    [self addSubview:self.contractButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(32)));
        make.top.equalTo(@(Anno750(25)));
        make.height.equalTo(@(Anno750(45)));
    }];
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(Anno750(30));
        make.centerY.equalTo(self.nameLabel);
        make.size.mas_equalTo(CGSizeMake(Anno750(82), Anno750(32)));
    }];
    [self.rangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(32)));
        make.centerY.equalTo(self.nameLabel);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(32)));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(Anno750(2));
        make.height.equalTo(@(Anno750(42)));
    }];
    [self.logoIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(32)));
        make.top.equalTo(self.moneyLabel.mas_bottom).offset(Anno750(20));
        make.size.mas_equalTo(CGSizeMake(Anno750(62), Anno750(62)));
    }];
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.logoIamgeView);
//        make.left.equalTo(self.logoIamgeView.mas_right).offset(Anno750(20));
        make.left.equalTo(@(Anno750(32)));
    }];
    [self.contractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(32)));
        make.centerY.equalTo(self.logoIamgeView);
        make.size.mas_equalTo(CGSizeMake(Anno750(150), Anno750(62)));
    }];
}

- (void)configureWithModel:(C_PartJobListModel *)model
{
    if (model.jobname && model.jobname.length != 0) {
        self.nameLabel.text = model.jobname;
    } else {
        self.nameLabel.text = model.classname;
    }
    if (model.wagetype == 0) {
        self.markLabel.text = @"日结";
    }
    else if (model.wagetype == 1)
    {
        self.markLabel.text = @"周结";
    }
    else if (model.wagetype == 3)
    {
        self.markLabel.text = @"完工结";
    }
    else if (model.wagetype == 2)
    {
        self.markLabel.text = @"月结";
    }
    
    if (model.juli > 0) {
        self.rangeLabel.text = [NSString stringWithFormat:@"距离%.0fm", model.juli];
    }
    else
    {
        self.rangeLabel.text = @"";
    }
    self.moneyLabel.text = model.wagedes;
    self.companyLabel.text = model.shopname;
    if (model.iscan == 0) {
        self.contractButton.hidden = NO;
    }
    else
    {
        self.contractButton.hidden = YES;
    }
    

    
}

@end
