//
//  ChatHeaderCell.m
//  XianYu
//
//  Created by lmh on 2019/7/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "ChatHeaderCell.h"


@implementation ChatHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = Color_White;
    }
    return self;
}

- (void)createUI{
    self.backView = [JSFactory creatViewWithColor:Color_White];
    [JSFactory configureWithView:self.backView cornerRadius:Anno750(6) isBorder:NO borderWidth:0 borderColor:nil];
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(32) textAlignment:(NSTextAlignmentLeft)];
    self.moneyLabel = [JSFactory creatLabelWithTitle:@"" textColor:UIColorFromRGB(0xFF794F) textFont:font750(30) textAlignment:(NSTextAlignmentRight)];
    self.leftImageView = [JSFactory creatImageViewWithImageName:@""];
    self.companyNameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_464646 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.rangeLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_878787 textFont:font750(28) textAlignment:(NSTextAlignmentRight)];
    [self.baseContentView addSubview:self.backView];
    [self.backView addSubview:self.nameLabel];
    [self.backView addSubview:self.moneyLabel];
    [self.backView addSubview:self.leftImageView];
    [self.backView addSubview:self.companyNameLabel];
    [self.backView addSubview:self.rangeLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.top.equalTo(@(Anno750(10)));
        make.bottom.equalTo(@(-Anno750(10)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(Anno750(25));
        make.left.equalTo(self.backView).offset(Anno750(24));
        make.height.equalTo(@(Anno750(45)));
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView).offset(-Anno750(24));
        make.centerY.equalTo(self.nameLabel);
    }];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(@(Anno750(27)));
        make.size.mas_equalTo(CGSizeMake(Anno750(55), Anno750(55)));
    }];
    [self.companyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(Anno750(20));
        make.centerY.equalTo(self.leftImageView);
    }];
    [self.rangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moneyLabel);
        make.centerY.equalTo(self.leftImageView);
    }];
}

- (void)configureWithLabelArray:(NSArray *)array
{
    for (UIView *view in self.backView.subviews) {
        if (view.tag >= 10000) {
            [view removeFromSuperview];
        }
    }
    CGFloat label_x = 0;
    CGFloat label_y = Anno750(92);
    CGFloat label_w = 0;
    CGFloat label_h = Anno750(47);
    UILabel *lastLabel = nil;
    for (int i = 0; i < array.count; i++) {
        NSString *str = array[i];
        CGSize size = [JSFactory getSize:str maxSize:(CGSizeMake(CGFLOAT_MAX, label_h)) font:[UIFont systemFontOfSize:Anno750(24)]];
        label_w = size.width + Anno750(40);
        if (i == 0) {
            label_x = Anno750(20);
        }
        else
        {
            label_x = CGRectGetMaxX(lastLabel.frame) + Anno750(10);
        }
        UILabel *label = [JSFactory creatLabelWithTitle:str textColor:Color_Green_2886FE textFont:font750(24) textAlignment:(NSTextAlignmentCenter)];
        label.backgroundColor = UIColorFromRGB(0xE9F3FF);
        label.frame = CGRectMake(label_x, label_y, label_w, label_h);
        [JSFactory configureWithView:label cornerRadius:Anno750(3) isBorder:NO borderWidth:0 borderColor:nil];
        label.tag = 10000 + i;
        [self.backView addSubview:label];
        lastLabel = label;
    }
}



// + (CGSize)sizeForMessageModel:(RCMessageModel *)model withCollectionViewWidth:(CGFloat)collectionViewWidth referenceExtraHeight:(CGFloat)extraHeight
//{
//    
//    return model.cellSize;
//}

//- (void)setDataModel:(RCMessageModel *)model
//{
//    [super setDataModel:model];
//    JobMessageContentModel *content = (JobMessageContentModel *)model.content;
//    NSDictionary *dict = content.dataDict;
//    NSLog(@"------------");
//
//}





@end
