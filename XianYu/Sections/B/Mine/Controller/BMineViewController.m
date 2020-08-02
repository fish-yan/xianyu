//
//  BMineViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BMineViewController.h"
#import "BRInfoViewController.h"
#import "BaseFuncViewController.h"
#import "C_RootViewController.h"
#import "C_Regist_EditUserInfoViewController.h"

@interface BMineViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *photoV;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *authStatusLab;
@property (weak, nonatomic) IBOutlet UIImageView *vipImg;
@property (weak, nonatomic) IBOutlet UILabel *chatCountLab;

@property (assign, nonatomic) NSInteger status;
@property (assign, nonatomic) NSInteger count;
@end

@implementation BMineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UserManager.share loadUserInfoData:XYB block:^(int code) {
        [self configView];
    } withConnect:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configView {
    [self requestUserfacestatus];
    self.nameLab.text = UserManager.share.infoModel.name;
    self.countLab.text = [NSString stringWithFormat:@"今日已发布%@个职位", [UserManager share].infoModel.releasenum];
    self.chatCountLab.text = [NSString stringWithFormat:@"今日已沟通%@人", [UserManager share].infoModel.linkupnum];
    [self.photoV sd_setImageWithURL:[NSURL URLWithString:UserManager.share.infoModel.photourl]];
    NSDictionary *vipDict = @{@"1":@"",@"2":@"icon_vip_huangjin",@"4":@"icon_vip_heijin", @"3":@"icon_vip_baijin"};
    NSString *imgNm = vipDict[[UserManager share].infoModel.grade];
    if (imgNm) {
        self.vipImg.image = [UIImage imageNamed:imgNm];
    }
    
}

- (IBAction)transform:(UIButton *)sender {
    [self pushToC];
}

- (void)pushToC {
    [UserManager.share loadUserInfoData:XYC block:^(int code) {
        if (code == 0) {
            [UserManager.share switchClient:XYC complete:^{
                UIApplication.sharedApplication.keyWindow.rootViewController = [C_RootViewController new];
            }];
        } else if (code == 404007) { // 信息未完成
            C_Regist_EditUserInfoViewController *vc = [C_Regist_EditUserInfoViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } withConnect:YES];
}

- (void)requestUserfacestatus {
    [NetworkManager sendReq:nil pageUrl:XY_B_userfacestatus complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count > 0 ) {
            NSInteger status = [arr.firstObject[@"status"] integerValue];
            self.status = status;
            self.count = [arr.firstObject[@"znum"] integerValue];
            switch (status) {
                case -1:
                    self.authStatusLab.text = @"未认证";
                    break;
                case 0:
                    self.authStatusLab.text = @"认证中";
                    break;
                case 1:
                    self.authStatusLab.text = @"已认证";
                    break;
                case 2:
                    self.authStatusLab.text = @"认证失败";
                    break;
                default:
                    break;
            }
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BRInfo"]) {
        BRInfoViewController *vc = segue.destinationViewController;
        vc.viewModel.type = 1;
    }
}

- (IBAction)helpAction:(id)sender {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"客服邮箱" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"kefu@huayuanvip.com" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:kefu@huayuanvip.com"]];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [sheet addAction:action1];
    [sheet addAction:action2];
    [self presentViewController:sheet animated:YES completion:nil];
}

- (IBAction)authAction:(UIButton *)sender {
    if (self.status == 0) {
        [ToastView show:@"认证中"];
        return;
    } else if (self.status == 1) {
        [ToastView show:@"已认证"];
        return;
    } else if (self.count <= 0) {
        [ToastView show:@"认证次数已用完"];
        return;
    }
    [UserManager.share requestAuth:^(NSString * _Nonnull token, NSString * _Nonnull ticketid, FaceCallBack  _Nonnull faceCallBack) {
        [UserManager start:token rpCompleted:^(AUDIT auditState) {
            faceCallBack();
        }withVC:self.navigationController];
    } complete:^{
        [self configView];
    }];
}


@end
