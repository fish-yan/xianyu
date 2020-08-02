//
//  C_FullJob_TipCell.m
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJob_TipCell.h"

@implementation C_FullJob_TipCell

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
    self.tipImageView = [JSFactory creatImageViewWithImageName:@"icon_c_fulljob_info_tip"];
    self.topLabel = [JSFactory creatLabelWithTitle:@"安全提示" textColor:Color_Black_323232 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.summaryLabel  = [[TTTAttributedLabel alloc]initWithFrame:(CGRectZero)];
    self.summaryLabel.font = [UIFont systemFontOfSize:font750(26)];
    self.summaryLabel.textColor = Color_Gray_828282;
//    self.summaryLabel.highlightedShadowColor = [UIColor redColor];
    self.summaryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.summaryLabel.numberOfLines = 0;
    self.summaryLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    self.summaryLabel.delegate = self;
    self.summaryLabel.text = @"若商家要求缴纳费用，请提高警惕并向我们举报";
//    self.summaryLabel.linkAttributes = @{
//                                         NSForegroundColorAttributeName:[UIColor redColor],
//                                         NSFontAttributeName:@(10)
//                                         };
//    [NSString setString:@"举报11" firstColor:[UIColor redColor] firstFont:font750(30) cutFromNum:2 secondColor:[UIColor blackColor] secondFont:10];
    NSRange range = [self.summaryLabel.text rangeOfString:@"举报"];
    [self.summaryLabel addLinkToURL:[NSURL URLWithString:@"http://github.com/mattt/"] withRange:range];
    self.topView = [JSFactory createLineView];
    self.bottomView = [JSFactory createLineView];
    [self addSubview:self.tipImageView];
    [self addSubview:self.topLabel];
    [self addSubview:self.summaryLabel];
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(44)));
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(Anno750(75), Anno750(75)));
    }];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipImageView);
        make.left.equalTo(self.tipImageView.mas_right).offset(Anno750(20));
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tipImageView);
        make.left.equalTo(self.topLabel);
        make.height.equalTo(@(Anno750(37)));
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@(0.5));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0.5));
        make.left.bottom.right.equalTo(@0);
    }];
}

//label链接
- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url{
    !self.reportAction ?: self.reportAction();
}

@end
