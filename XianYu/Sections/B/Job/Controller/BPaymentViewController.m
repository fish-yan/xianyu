
//
//  BPaymentViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BPaymentViewController.h"
#import "XYConstUtils.h"

@interface BPaymentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *typeTF;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UITextField *unitTF;

@end

@implementation BPaymentViewController

- (NSString *)money {
    if (!_money) {
        _money = @"";
    }
    return _money;
}

- (NSString *)type {
    if (!_type) {
        _type = @"";
    }
    return _type;
}

- (NSString *)unit {
    if (!_unit) {
        _unit = @"";
    }
    return _unit;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeTF.text = [self detransPayType:self.type];
    self.moneyTF.text = self.money;
    self.unitTF.text = self.unit;
}
- (IBAction)typeAction:(id)sender {
    XYActionSheetViewController *action = [XYActionSheetViewController show:xy_settleType complete:^(NSString * _Nonnull title) {
        self.typeTF.text = title;
    }];
    action.selectTitle = self.typeTF.text;
    action.headTitle = @"结算方式";
    
}

- (IBAction)unitAction:(id)sender {
    XYActionSheetViewController *action = [XYActionSheetViewController show:xy_unitType complete:^(NSString * _Nonnull title) {
        self.unitTF.text = title;
    }];
    action.selectTitle = self.unitTF.text;
    action.headTitle = @"薪资单位";
}

- (IBAction)commitAction:(id)sender {
    [self.view endEditing:YES];
    if (self.typeTF.text.length == 0) {
        [ToastView show:@"请选择结算方式"];
        return;
    }
    if (self.moneyTF.text.length == 0) {
        [ToastView show:@"请填写薪资"];
        return;
    }
    if (self.unitTF.text.length == 0) {
        [ToastView show:@"请选择薪资单位"];
        return;
    }
    !self.complete ?: self.complete(self.moneyTF.text, self.unitTF.text, [self transPayType:self.typeTF.text]);
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSString *)transPayType:(NSString *)type {
    if ([type isEqualToString:@"日结"]) {
        return @"0";
    } else if ([type isEqualToString:@"周结"]) {
        return @"1";
    } else if ([type isEqualToString:@"月结"]) {
        return @"2";
    } else if ([type isEqualToString:@"完工结"]) {
        return @"3";
    } else if ([type isEqualToString:@"半月结"]) {
        return @"4";
    } else {
        return @"";
    }
}

- (NSString *)detransPayType:(NSString *)type {
    if ([type isEqualToString:@"0"]) {
        return @"日结";
    } else if ([type isEqualToString:@"1"]) {
        return @"周结";
    } else if ([type isEqualToString:@"2"]) {
        return @"月结";
    } else if ([type isEqualToString:@"3"]) {
        return @"完工结";
    } else if ([type isEqualToString:@"4"]) {
        return @"半月结";
    } else {
        return @"";
    }
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
