//
//  ADViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/28.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "ADViewController.h"
#import "BaseFuncViewController.h"
#import "C_RootViewController.h"
#import "BJobPriceViewController.h"

@interface ADViewController ()

@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    imgV.image = [UIImage imageNamed:@"spls.png"];
    [self.view addSubview:imgV];
    [self requestLoginclient];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)requestLoginclient {
    
    [NetworkManager sendReq:nil pageUrl:XY_loginclient isLoading:NO complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            NSString *loginclient = [NSString stringWithFormat:@"%@", arr.firstObject[@"loginclient"]];
            if ([loginclient isEqualToString:@"1"]) {
                [self pushToC];
            } else if ([loginclient isEqualToString:@"0"]) {
                [self pushToB];
            } else {
                UIApplication.sharedApplication.keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[BaseFuncViewController new]];
            }
        } else {
            UIApplication.sharedApplication.keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[BaseFuncViewController new]];
        }
    } failure:^(NSInteger code, NSString *msg) {
        UIApplication.sharedApplication.keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[BaseFuncViewController new]];
    }];
    
}

- (void)pushToC {
    [UserManager.share loadUserInfoData:XYC block:^(int code) {
        if (code == 0) {
            [UserManager.share switchClient:XYC complete:^{
                UIApplication.sharedApplication.keyWindow.rootViewController = [C_RootViewController new];
            }];
        } else {
            UIApplication.sharedApplication.keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[BaseFuncViewController new]];
        }
    } withConnect:YES];
    
}

- (void)pushToB {
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
                UIApplication.sharedApplication.keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
            }
        } else {
            UIApplication.sharedApplication.keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[BaseFuncViewController new]];
        }
    } withConnect:YES];
}


@end
