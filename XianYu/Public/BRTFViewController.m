//
//  BRStoreNameViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRTFViewController.h"

@interface BRTFViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;

@property (copy, nonatomic) NSString *tit;

@property (copy, nonatomic) NSString *detail;

@property (copy, nonatomic) NSString *des;

@property (copy, nonatomic) NSString *placeholder;

@property (nonatomic, copy) void(^complete)(NSString *name);

@end

@implementation BRTFViewController

- (NSInteger)maxLen {
    if (!_maxLen) {
        _maxLen = 10000;
    }
    return _maxLen;
}

- (UIKeyboardType)keyboardType {
    if (!_keyboardType) {
        _keyboardType = UIKeyboardTypeDefault;
    }
    return _keyboardType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = self.tit;
    self.desLab.text = self.des;
    self.nameTF.placeholder = self.placeholder;
    self.nameTF.text = self.detail;
    self.nameTF.keyboardType = self.keyboardType;
    [self.nameTF becomeFirstResponder];
}

+ (BRTFViewController *)start:(NSString *)title detail:(NSString *)detail des:(NSString *)des placeholder:(NSString *)placeholder complete:(void(^)(NSString *text))complete {
    BRTFViewController *tfvc = [[UIStoryboard storyboardWithName:@"XYPublic" bundle:nil] instantiateViewControllerWithIdentifier:@"BRTFViewController"];
    UIViewController *vc = [UIViewController visibleViewController];
    tfvc.title = title;
    tfvc.tit = title;
    tfvc.detail = detail;
    tfvc.des = des;
    tfvc.placeholder = placeholder;
    tfvc.complete = complete;
    [vc.navigationController pushViewController:tfvc animated:YES];
    return tfvc;
}

- (IBAction)saveAction:(id)sender {
    if (self.nameTF.text.length <= 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请填写门店名称" duration:1.0f];
        return;
    }
    !self.complete ?: self.complete(self.nameTF.text);
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

- (IBAction)textChange:(UITextField *)sender {
    if (sender.text.length > self.maxLen) {
        sender.text = [sender.text substringToIndex:self.maxLen];
    }
}


@end
