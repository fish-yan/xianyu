
//
//  CustomeDatePickerView.m
//  YouShang
//
//  Created by lmh on 2018/8/3.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "CustomeDatePickerView.h"

@implementation CustomeDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = UIColorFromRGBA(0x000000, 0.3);
    }
    return self;
}

- (void)createUI
{
    self.backView = [JSFactory creatViewWithColor:Color_White];
    self.titleLabel = [JSFactory creatLabelWithTitle:@"出生日期" textColor:Color_Black_464646 textFont:font750(30) textAlignment:(NSTextAlignmentCenter)];
    self.cancleButton = [JSFactory creatButtonWithTitle:@"取消" textFont:font750(28) titleColor:UIColorFromRGB(0xC3C3C3) backGroundColor:Color_White];
    self.sureButton = [JSFactory creatButtonWithTitle:@"确定" textFont:font750(28) titleColor:Color_Blue_32A060 backGroundColor:Color_White];
    [self.cancleButton addTarget:self action:@selector(clickCancleButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.sureButton addTarget:self action:@selector(clickSureButton) forControlEvents:(UIControlEventTouchUpInside)];
    self.lineView = [JSFactory createLineView];
    self.datePicker = [[UIDatePicker alloc]initWithFrame:(CGRectZero)];
    [self.datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    [self.datePicker setCalendar:[NSCalendar currentCalendar]];
    [self.datePicker setDate:[NSDate date]];
    [self.datePicker setDatePickerMode:(UIDatePickerModeDate)];
    [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    self.datePicker.maximumDate = [NSDate date];
    self.datePicker.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.datePicker.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:self.backView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.cancleButton];
    [self.backView addSubview:self.sureButton];
    [self.backView addSubview:self.lineView];
    [self.backView addSubview:self.datePicker];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@(Anno750(500)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.height.equalTo(@(Anno750(90)));
        make.top.equalTo(self.backView);
    }];
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView);
        make.top.equalTo(self.backView);
        make.size.mas_equalTo(CGSizeMake(Anno750(90), Anno750(90)));
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Anno750(90), Anno750(90)));
        make.right.equalTo(self.backView);
        make.top.equalTo(self.backView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.equalTo(@(Anno750(1)));
    }];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView);
        make.right.equalTo(self.backView);
        make.bottom.equalTo(self.backView);
        make.top.equalTo(self.lineView.mas_bottom);
    }];
}

- (void)dateChange:(UIDatePicker *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:date.date];
    self.currentString = str;
   
}

- (void)clickCancleButton
{
    [UIView animateWithDuration:0.3f animations:^{
        [self removeFromSuperview];
    }];    
}

- (void)clickSureButton
{
    [UIView animateWithDuration:0.3f animations:^{
        [self removeFromSuperview];
    }];
    if (self.currentString.length > 0) {
        if ([self.viewController respondsToSelector:@selector(configureWithDateString:)]) {
            [self.delegate configureWithDateString:self.currentString];
        }
    }
}



@end
