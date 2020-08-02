//
//  BJDateViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BJDateViewController.h"
#import "XianYu-Swift.h"

@interface BJDateViewController ()
@property (weak, nonatomic) IBOutlet UIButton *date1Btn;
@property (weak, nonatomic) IBOutlet UIButton *date2Btn;
@property (weak, nonatomic) IBOutlet UIButton *time1Btn;
@property (weak, nonatomic) IBOutlet UIButton *time2Btn;

@property (nonatomic, strong) NSDate *date1;
@property (nonatomic, strong) NSDate *date2;
@property (nonatomic, strong) NSDate *time1;
@property (nonatomic, strong) NSDate *time2;

@end

@implementation BJDateViewController

- (void)setDate1Str:(NSString *)date1Str {
    _date1Str = date1Str;
    self.date1 = [self formateStr:date1Str formatter:@"yyyy-MM-dd"];
}

- (void)setDate2Str:(NSString *)date2Str {
    _date2Str = date2Str;
    self.date2 = [self formateStr:date2Str formatter:@"yyyy-MM-dd"];
}

- (void)setTime1Str:(NSString *)time1Str {
    _time1Str = time1Str;
    self.time1 = [self formateStr:time1Str formatter:@"HH:mm"];
}

- (void)setTime2Str:(NSString *)time2Str {
    _time2Str = time2Str;
    self.time2 = [self formateStr:time2Str formatter:@"HH:mm"];
}

- (NSDate *)date1 {
    if (!_date1) {
        _date1 = [NSDate date];
    }
    return _date1;
}

- (NSDate *)time1 {
    if (!_time1) {
        _time1 = [self defaultDate:@"09:00"];
    }
    return _time1;
}

- (NSDate *)time2 {
    if (!_time2) {
        _time2 = [self defaultDate:@"18:00"];
    }
    return _time2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.date1Btn setTitle:[self formateDate:self.date1 formatter:@"yyyy.MM.dd"] forState:UIControlStateNormal];
    if (self.date2) {
        [self.date2Btn setTitle:[self formateDate:self.date2 formatter:@"yyyy.MM.dd"] forState:UIControlStateNormal];
    }
    [self.time1Btn setTitle:[self formateDate:self.time1 formatter:@"HH:mm"] forState:UIControlStateNormal];
    [self.time2Btn setTitle:[self formateDate:self.time2 formatter:@"HH:mm"] forState:UIControlStateNormal];
    
}
- (IBAction)dateAction:(UIButton *)sender {
    NSString *str = @"";
    if ([sender isEqual:self.date1Btn]) {
        str = @"开始日期";
    } else {
        str = @"结束日期";
    }
    __block XYAlertDatePickerView *datePicker = [XYAlertDatePickerView ShowAlertDatePickerWithNameStr:str withViewController:self withSureBlock:^(id returnData) {
        [sender setTitle:returnData forState:(UIControlStateNormal)];
        if ([sender isEqual:self.date1Btn]) {
            self.date1 = datePicker.currentDate;
        } else {
            self.date2 = datePicker.currentDate;
        }
    }];
    datePicker.datePicker.datePickerMode = PGDatePickerModeDate;
    if ([sender isEqual:self.date1Btn]) {
        datePicker.datePicker.date = self.date1;
        datePicker.datePicker.minimumDate = [NSDate date];
        if (self.date2) {
            datePicker.datePicker.maximumDate = self.date2;
        } else {
            datePicker.datePicker.maximumDate = [NSDate setYear:2100];
        }
    } else {
        datePicker.datePicker.date = self.date2;
        datePicker.datePicker.minimumDate = self.date1;
        datePicker.datePicker.maximumDate = [NSDate setYear:2100];;
    }
    
}

- (IBAction)timeAction:(UIButton *)sender {
    NSString *str = @"";
    if ([sender isEqual:self.time1Btn]) {
        str = @"开始时间";
    } else {
        str = @"结束时间";
    }
    __block XYAlertDatePickerView *datePicker = [XYAlertDatePickerView ShowAlertDatePickerWithNameStr:str withViewController:self withSureBlock:^(id returnData) {
        [sender setTitle:returnData forState:(UIControlStateNormal)];
        if ([sender isEqual:self.time1Btn]) {
            self.time1 = datePicker.currentDate;
        } else {
            self.time2 = datePicker.currentDate;
        }
    }];
    datePicker.datePicker.datePickerMode = PGDatePickerModeTime;
    if ([sender isEqual:self.time1Btn]) {
        datePicker.datePicker.date = self.time1;
        datePicker.datePicker.minimumDate = [NSDate setHour:0 minute:0];
        datePicker.datePicker.maximumDate = [NSDate setHour:23 minute:59];
    } else {
        datePicker.datePicker.date = self.time2;
        datePicker.datePicker.minimumDate = [NSDate setHour:0 minute:0];
        datePicker.datePicker.maximumDate = [NSDate setHour:23 minute:59];
    }
}

- (NSString *)formateDate:(NSDate *)date formatter:(NSString *)formatter {
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    formate.dateFormat = formatter;
    return [formate stringFromDate:date];
}

- (NSDate *)formateStr:(NSString *)str formatter:(NSString *)formatter {
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    formate.dateFormat = formatter;
    return [formate dateFromString:str];
}

- (NSDate *)defaultDate:(NSString *)str {
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    formate.dateFormat = @"HH:mm";
    return [formate dateFromString:str];
}

- (IBAction)commitAction:(UIBarButtonItem *)sender {
    if (!self.date1) {
        [ToastView show:@"请选择兼职开始日期"];
        return;
    }
    if (!self.date2) {
        [ToastView show:@"请选择兼职结束日期"];
        return;
    }
    if (!self.time1) {
        [ToastView show:@"请选择兼职开始时间"];
        return;
    }
    if (!self.time2) {
        [ToastView show:@"请选择兼职结束时间"];
        return;
    }
    !self.complete ?: self.complete(self.date1Btn.titleLabel.text, self.date2Btn.titleLabel.text, self.time1Btn.titleLabel.text, self.time2Btn.titleLabel.text);
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
