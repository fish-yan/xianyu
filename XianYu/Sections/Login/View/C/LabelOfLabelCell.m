//
//  LabelOfLabelCell.m
//  XianYu
//
//  Created by lmh on 2019/6/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "LabelOfLabelCell.h"

@implementation LabelOfLabelCell

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
    self.arrowImageView = [JSFactory createArrowImageView];
    self.summaryLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_A5A5A5 textFont:font750(30) textAlignment:(NSTextAlignmentRight)];
    self.printField = [JSFactory creatTextFieldWithPlaceHolder:@"请填写" textAlignment:(NSTextAlignmentRight) textColor:Color_Black_323232 textFont:font750(30)];
    self.lineView = [JSFactory createLineView];
    self.userImageView = [JSFactory creatImageViewWithImageName:@""];
    
    [JSFactory configureWithView:self.userImageView cornerRadius:Anno750(50) isBorder:NO borderWidth:0 borderColor:nil];
    self.userImageView.hidden = YES;
    [self addSubview:self.nameLabel];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.summaryLabel];
    [self addSubview:self.printField];
    [self addSubview:self.lineView];
    [self addSubview:self.userImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(150)));
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(Anno750(28), Anno750(28)));
    }];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.mas_left).offset(-Anno750(2));
        make.centerY.equalTo(@0);
        make.left.equalTo(self.nameLabel.mas_right).offset(Anno750(20));
    }];
    [self.printField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(self.nameLabel.mas_right).offset(Anno750(20));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(Anno750(100), Anno750(100)));
    }];
}

- (void)configureWithNameStr:(NSString *)nameStr withIsField:(BOOL)isField withPlaceHolder:(NSString *)placeHolder withSummarStr:(NSString *)summaryStr
{
    self.nameLabel.text = nameStr;
    if (isField) {
        self.printField.hidden = NO;
        self.summaryLabel.hidden = YES;
        self.printField.placeholder = placeHolder;
        
    }
    else
    {
        self.printField.hidden = YES;
        self.summaryLabel.hidden = NO;
        self.summaryLabel.text = summaryStr;
    }
    
    
}

@end
