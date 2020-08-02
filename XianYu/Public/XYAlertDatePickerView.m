//
//  XYAlertDatePickerView.m
//  XianYu
//
//  Created by lmh on 2019/7/24.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "XYAlertDatePickerView.h"
#import "PrefixHeader.pch"
@implementation XYAlertDatePickerView



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
    self.cancleButton = [JSFactory creatButtonWithTitle:@"取消" textFont:font750(30) titleColor:Color_Black_878787 backGroundColor:Color_White];
    self.nameLabel = [JSFactory creatLabelWithTitle:@"开始时间" textColor:Color_Black_464646 textFont:font750(30) textAlignment:(NSTextAlignmentCenter)];
    self.sureBUtton = [JSFactory creatButtonWithTitle:@"保存" textFont:font750(30) titleColor:Color_Blue_32A060 backGroundColor:Color_White];
    
    [[self.cancleButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self removeFromSuperview];
    }];
    
    
    
    
    self.datePickManager = [[PGDatePickManager alloc]init];
    self.datePicker = self.datePickManager.datePicker;
    self.datePicker.delegate = self;
    self.datePicker.autoSelected = YES;
    self.datePicker.lineBackgroundColor = Color_Blue_32A060;
    self.datePicker.textColorOfSelectedRow = Color_Blue_32A060;
    self.datePicker.datePickerMode = PGDatePickerModeDate;
    self.datePicker.isHiddenMiddleText = NO;
    self.datePicker.maximumDate = [NSDate setYear:2100];
    self.datePicker.minimumDate = [NSDate setYear:2000];
    self.lineView = [JSFactory createLineView];
    [self addSubview:self.backView];
    [self.backView addSubview:self.cancleButton];
    [self.backView addSubview:self.nameLabel];
    [self.backView addSubview:self.sureBUtton];
    [self.backView addSubview:self.datePicker];
    [self.backView addSubview:self.lineView];
    
    
    self.datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
        NSLog(@"---------");
    };
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@(Anno750(500)));
    }];
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.height.width.equalTo(@(Anno750(90)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.backView);
        make.height.equalTo(@(Anno750(90)));
    }];
    [self.sureBUtton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.backView);
        make.height.width.equalTo(@(Anno750(90)));
    }];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.right.bottom.equalTo(self.backView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.top.equalTo(self.backView).offset(Anno750(90));
        make.height.equalTo(@0.5);
    }];
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents
{
    NSString *dateStr = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld", dateComponents.year, dateComponents.month, dateComponents.day, dateComponents.hour, dateComponents.minute, dateComponents.second];
    NSDateFormatter *f = [NSDateFormatter new];
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    self.currentDate = [f dateFromString:dateStr];
    switch (datePicker.datePickerMode) {
        case PGDatePickerModeYearAndMonth:
             self.timeStr = [NSString stringWithFormat:@"%ld-%02ld",dateComponents.year, dateComponents.month];
            break;
        case PGDatePickerModeDate:
            self.timeStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld",dateComponents.year, dateComponents.month, dateComponents.day];
            break;
        case PGDatePickerModeTime:
            self.timeStr = [NSString stringWithFormat:@"%02ld:%02ld",dateComponents.hour, dateComponents.minute];
            break;
        default:
            break;
    }
    
}

+ (XYAlertDatePickerView *)ShowAlertDatePickerWithNameStr:(NSString *)nameStr  withViewController:(UIViewController *)viewController withSureBlock:(CompleteBlockData)sureBlock
{
    XYAlertDatePickerView *timeView = [[XYAlertDatePickerView alloc]initWithFrame:viewController.view.bounds];
    timeView.nameLabel.text = nameStr;
    [[timeView.sureBUtton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[timeView.sureBUtton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [timeView removeFromSuperview];
            //            [timeView.mySubject sendNext:timeView.timeStr];
            sureBlock(timeView.timeStr);
        }];
    }];
    [viewController.view addSubview:timeView];
    return timeView;
}



@end
