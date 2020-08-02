

//
//  BJobPayResultViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/25.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BJobPayResultViewController.h"

@interface BJobPayResultViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UIButton *authBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIButton *unAuthBtn;

@end

@implementation BJobPayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([@[@"0", @"1"] containsObject:self.stauts]) { // 已认证过或认证中
        self.desLab.hidden = YES;
        self.countLab.text = @"";
        [self.authBtn setTitle:@"回到首页" forState:UIControlStateNormal];
        self.unAuthBtn.hidden = YES;
    } else {
        self.desLab.hidden = NO;
        [self.authBtn setTitle:@"立即免费认证" forState:UIControlStateNormal];
        self.countLab.text = [NSString stringWithFormat:@"剩余%@次机会", self.snum];
        self.unAuthBtn.hidden = NO;
    }
}

- (IBAction)authBtnAction:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:notification_reload_job_list object:nil];
    if ([@[@"0", @"1"] containsObject:self.stauts]) { // 已认证过或认证中
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [UserManager.share requestAuth:^(NSString * _Nonnull token, NSString * _Nonnull ticketid, FaceCallBack  _Nonnull faceCallBack) {
            [UserManager start:token rpCompleted:^(AUDIT auditState) {
                faceCallBack();
            }withVC:self.navigationController];
        } complete:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
}

- (IBAction)unAuthAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:notification_reload_job_list object:nil];

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
