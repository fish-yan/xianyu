//
//  CityMarkCell.m
//  New_MeiChai
//
//  Created by lmh on 2018/6/13.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "CityMarkCell.h"

@implementation CityMarkCell

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
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (CGFloat)configureWithArray:(NSArray *)array section:(NSInteger)section{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    CGFloat origin_x = Anno750(24);
    CGFloat origin_y = Anno750(10);
    CGFloat button_w = (KScreenWidth - Anno750(48) - Anno750(25) * 3 - Anno750(40)) / 3.0;
    CGFloat button_h = Anno750(60);
    CGFloat button_x = 0;
    CGFloat button_y = 0;
    UIButton *lastButton;
    for (int i = 0; i < array.count; i++) {
        id myID = array[i];
        NSString *str;
        if ([myID isKindOfClass:[CityModel class]]) {
            CityModel *model = (CityModel *)myID;
            str = model.name;
        }
        else
        {
            str = myID[@"name"];
        }
        
        if (lastButton == nil) {
            button_x = origin_x;
            button_y = origin_y;
        }
        else
        {
            if (CGRectGetMaxX(lastButton.frame) + Anno750(20) + button_w + Anno750(24) + Anno750(40) > KScreenWidth) {
                button_x = origin_x;
                button_y = CGRectGetMaxY(lastButton.frame) + Anno750(25);
            }
            else
            {
                button_x = CGRectGetMaxX(lastButton.frame) + Anno750(25);
                button_y = CGRectGetMinY(lastButton.frame);
            }
        }
        UIButton *button = [JSFactory creatButtonWithTitle:str textFont:font750(28) titleColor:Color_Black_A5A5A5 backGroundColor:Color_White];
        [JSFactory configureWithView:button cornerRadius:Anno750(6) isBorder:YES borderWidth:Anno750(1) borderColor:Color_Black_A5A5A5];
        button.frame = CGRectMake(button_x, button_y, button_w, button_h);
        button.tag = section * 1000 + i + 2000;
        [button addTarget:self action:@selector(clickCityButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:button];
        lastButton = button;
    }
    return CGRectGetMaxY(lastButton.frame) + Anno750(40);
}

- (void)clickCityButton:(UIButton *)sender
{
    if ([self.viewController respondsToSelector:@selector(clickCityButtonSection:withTag:)]) {
        [self.delegate clickCityButtonSection:(sender.tag/1000)-2 withTag:(sender.tag%1000)];
    }
}

@end
