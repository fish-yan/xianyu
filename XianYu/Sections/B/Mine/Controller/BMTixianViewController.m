//
//  BMTixianViewController.m
//  XianYu
//
//  Created by Yan on 2019/9/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BMTixianViewController.h"

@interface BMTixianViewController ()
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UITextField *telTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *aliaAcountTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, assign) NSInteger second;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation BMTixianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
}

- (IBAction)getCodeAction:(UIButton *)sender {
    [self requestGetcode];
}

- (IBAction)tixianAction:(UIButton *)sender {
    [self requestTixian];
}

- (void)request {
    [NetworkManager sendReq:@{@"uid":@"", @"sign":@"", @"timestamp":@""} pageUrl:@"withdrawinfo" complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr && arr.count > 0) {
            NSDictionary *dict = arr.firstObject;
            if (dict[@"taskmoney"] != [NSNull null]) {
                self.moneyTF.text = dict[@"taskmoney"] ?: @"0";
            }
            if (dict[@"mobile"] != [NSNull null]) {
                self.telTF.text = dict[@"mobile"] ?: @"";
                self.tel = dict[@"mobile"];
            }
        }
    }];
}

- (void)requestGetcode {
    NSDictionary *params = @{@"uid":@"", @"sign":@"", @"timestamp":@""};
    [NetworkManager sendReq:params pageUrl:@"getmobilwithdrawevc" complete:^(id result) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
        self.second = 60;
    }];
}

- (void)requestTixian {
    if (self.nameTF.text.length == 0) {
        [ToastView show:@"请输入支付宝姓名"];
    }
    if (self.aliaAcountTF.text.length == 0) {
        [ToastView show:@"请输入支付宝账号"];
    }
    if (self.codeTF.text.length == 0) {
        [ToastView show:@"请输入验证码"];
    }
    NSDictionary *params = @{@"alipayrealname":self.nameTF.text,
                             @"alipayaccount":self.aliaAcountTF.text,
                             @"actcode":self.codeTF.text,
    };
    [NetworkManager sendReq:params pageUrl:@"withdraw" complete:^(id result) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)countDownAction {
    self.second--;
    self.codeBtn.enabled = NO;
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%lds后重试",(long)self.second] forState:(UIControlStateDisabled)];
    self.codeBtn.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.codeBtn.layer.bcolor = UIColorFromRGB(0xa5a5a5);
    if (self.second == 0) {
        self.codeBtn.enabled = YES;
        self.second = 60;
        [self.timer invalidate];
        self.timer = nil;
        self.codeBtn.backgroundColor = UIColorFromRGB(0xEFF7F2);
        self.codeBtn.layer.bcolor = UIColorFromRGB(0x32A060);
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
