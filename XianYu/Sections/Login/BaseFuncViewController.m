//
//  BaseFuncViewController.m
//  XianYu
//
//  Created by lmh on 2019/6/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseFuncViewController.h"
#import "C_Regist_EditUserInfoViewController.h"
#import "BRInfoViewController.h"
#import "UserInfoModel.h"
#import "C_RootViewController.h"
#import "BJobPriceViewController.h"

@interface BaseFuncViewController ()

@property (nonatomic, strong) UIButton *findJobButton;

@property (nonatomic, strong) UIButton *recruitButton;

@end

@implementation BaseFuncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"咸鱼工作" titleColor:Color_Black_323232 andNavColor:Color_White];
    [self drawBackButtonWithBlackStatus:(NavigationBackType_Black)];
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)createUI
{
    self.findJobButton = [JSFactory creatButtonWithNormalImage:@"icon_base_func_findjob" selectImage:@"icon_base_func_findjob"];
    self.recruitButton = [JSFactory creatButtonWithNormalImage:@"icon_base_func_findman" selectImage:@"icon_base_func_findman"];
    [[self.findJobButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self pushToC];
    }];
    [[self.recruitButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self pushToB];
    }];
    [self.view addSubview:self.findJobButton];
    [self.view addSubview:self.recruitButton];
    [self.findJobButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(45)));
        make.right.equalTo(@(-Anno750(45)));
        make.height.equalTo(@((KScreenWidth - Anno750(90)) * 260/660.0));
        make.bottom.equalTo(self.view.mas_centerY).offset(-Anno750(36));
    }];
    [self.recruitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(45)));
        make.right.equalTo(@(-Anno750(45)));
        make.height.equalTo(@((KScreenWidth - Anno750(90)) * 260/660.0));
        make.top.equalTo(self.view.mas_centerY).offset(Anno750(36));
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)pushToC {
    [UserManager.share loadUserInfoData:XYC block:^(int code) {
        if (code == 0) {
            [UserManager.share switchClient:XYC complete:^{
                UIApplication.sharedApplication.keyWindow.rootViewController = [C_RootViewController new];
            }];
        } else if (code == 404007) {
            C_Regist_EditUserInfoViewController *VC = [C_Regist_EditUserInfoViewController new];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
    } withConnect:YES];
}

- (void)pushToB {
    NSLog(@"%d", XYB);
    [UserManager.share loadUserInfoData:XYB block:^(int code) {
        if (code == 0) {
            if ([[UserManager share].infoModel.havepay isEqualToString:@"1"]) {
                [UserManager.share switchClient:XYB complete:^{
                    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
                    UIApplication.sharedApplication.keyWindow.rootViewController = vc;
                }];
            } else { // 去支付
                BJobPriceViewController *vc = [[UIStoryboard storyboardWithName:@"BJob" bundle:nil] instantiateViewControllerWithIdentifier:@"BJobPriceViewController"];
                vc.isFirst = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } else if (code == 404007) {
            BRInfoViewController *vc = [[UIStoryboard storyboardWithName:@"Register" bundle:nil] instantiateViewControllerWithIdentifier:@"BRInfoViewController"];
            vc.viewModel.type = 0;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:true];
        }
    } withConnect:YES];
}


@end
