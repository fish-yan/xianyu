//
//  BJobDetailViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BJobDetailViewController.h"
#import "BJobModel.h"
#import "BJobListVM.h"
#import "BPostJobViewController.h"
#import "C_MapViewController.h"
#import "XianYu-Swift.h"

@interface BJobDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *jobLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIView *tagsLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *expLab;
@property (weak, nonatomic) IBOutlet UILabel *eduLab;
@property (weak, nonatomic) IBOutlet UIImageView *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsHeight;
@property (weak, nonatomic) IBOutlet UIView *unopenView;
@property (weak, nonatomic) IBOutlet UIView *overdueView;
@property (weak, nonatomic) IBOutlet UIView *putUpView;
@property (strong, nonatomic) BJobModel *model;
@end

@implementation BJobDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[BJobModel alloc]init];
    [self request];
    [CommanTool addLoadView:self.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(request) name:notification_reload_job_detail object:nil];
}

- (void)request {
    NSMutableDictionary *params =  @{@"id": self.jobId}.mutableCopy;
//    NSString *lon = @"";
//    NSString *lat = @"";
//    if (UserManager.share.longitude != 0 && UserManager.share.latitude != 0) {
//        lon = [NSString stringWithFormat:@"%f", UserManager.share.longitude];
//        lat = [NSString stringWithFormat:@"%f", UserManager.share.latitude];
//        [params setValue:lon forKey:@"lon"];
//        [params setValue:lat forKey:@"lad"];
//    }
    NSString *API = XY_B_getmyreleasejobbyid;
    if (self.type == 0) {
        API = XY_B_getmyreleasejobbyid;
    } else {
        API = XY_B_getmyreleasepartjobbyid;
    }
    [NetworkManager sendReq:params pageUrl:API isLoading:NO complete:^(id result) {
        NSArray *arr = result[@"data"];
        [CommanTool removeViewType:4 parentView:self.view];
        [CommanTool removeViewType:4 parentView:self.view];
        if (arr.count > 0) {
            self.model = [BJobModel yy_modelWithJSON:arr.firstObject];
            [self configView];
        }
    } failure:^(NSInteger code, NSString *msg) {
        [CommanTool removeViewType:4 parentView:self.view];
        [CommanTool removeViewType:4 parentView:self.view];
        [CommanTool addNoDataView:self.view withImage:@"icon_no_data" contentStr:@"暂无内容"];
    }];
}


- (void)configView {
    if (self.model.jobname && self.model.jobname.length != 0) {
        self.jobLab.text = self.model.jobname;
    } else {
        self.jobLab.text = self.model.classname;
    }
    self.typeLab.text = self.type == 0 ? @"全职" : @"兼职";
    self.moneyLab.text = self.model.wagedes;
    CGFloat height = [XYTagsView initTagsWith:self.tagsLab array:self.model.welfare];
    self.tagsHeight.constant = height;
    self.ageLab.text = [NSString stringWithFormat:@"年龄要求：%@", self.model.age];
    self.expLab.text = [NSString stringWithFormat:@"经验要求：%@", self.model.jobexp];
    self.eduLab.text = [NSString stringWithFormat:@"学历要求：%@", self.model.educationname];
    self.companyLab.text = self.model.shopname;
    self.addressLab.text = self.model.address;
    self.desLab.text = self.model.jobdesc;
    self.distanceLab.text = self.model.juli;
    self.unopenView.hidden = YES;
    self.putUpView.hidden = YES;
    self.overdueView.hidden = YES;
    if ([self.model.status isEqualToString:@"0"]) { // 下线
        self.statusLab.image = [UIImage imageNamed:@"icon_b_job_yixiaxian"]; 
        self.unopenView.hidden = NO;
        [self.openBtn setTitle:@"上线" forState:UIControlStateNormal];
    } else if ([self.model.status isEqualToString:@"1"]) { // 招聘中
        self.statusLab.image = [UIImage imageNamed:@"icon_b_job_yishangxina"];
        self.putUpView.hidden = NO;
    } else if ([self.model.status isEqualToString:@"2"]) { // 已到期
        self.statusLab.image = [UIImage imageNamed:@"icon_b_job_yidaoqi"];
        self.overdueView.hidden = NO;
    } else if ([self.model.status isEqualToString:@"3"]) { // 未开放 未付费
        self.statusLab.image = [UIImage imageNamed:@"icon_b_job_weikaifang"];
        self.unopenView.hidden = NO;
        [self.openBtn setTitle:@"立即开放" forState:UIControlStateNormal];
        FYAlertController *alert = [[FYAlertController alloc] initWithTitle:@"" msg:@"购买套餐，有效期内无限发布上线招聘职位，和求职者无限畅聊" commit:@"前往购买" cancel:@"取消" close:false];
        [self presentViewController:alert animated:YES completion:nil];
        [alert actionWithCommit:^{
            [self performSegueWithIdentifier:@"BJobPrice" sender:nil];
        } cancel:^{} close:^{}];
    } else if ([self.model.status isEqualToString:@"4"]) { // 未开放 付费未认证
        self.statusLab.image = [UIImage imageNamed:@"icon_b_job_weikaifang"];
        self.unopenView.hidden = NO;
        [self.openBtn setTitle:@"立即开放" forState:UIControlStateNormal];
        FYAlertController *alert = [[FYAlertController alloc] initWithTitle:@"" msg:@"为了保障您和求职者共同的权益\n还需要您进行认证哦～" commit:@"立即认证" cancel:@"取消" close:false];
        [self presentViewController:alert animated:YES completion:nil];
        [alert actionWithCommit:^{
            [UserManager.share requestAuth:^(NSString * _Nonnull token, NSString * _Nonnull ticketid, FaceCallBack  _Nonnull faceCallBack) {
                [UserManager start:token rpCompleted:^(AUDIT auditState) {
                    faceCallBack();
                }withVC:self.navigationController];
            } complete:^{
                [self request];
            }];
        } cancel:^{} close:^{}];
    }
}

- (IBAction)moreAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    CGSize size = [JSFactory getSize:self.desLab.text maxSize:(CGSizeMake(KScreenWidth - 44, CGFLOAT_MAX)) font:[UIFont systemFontOfSize:14]];
    CGFloat height = MAX(size.height, 90);
    self.height.constant = sender.selected ? height : 90;
}

- (IBAction)openAction:(UIButton *)sender {
    if ([self.model.status isEqualToString:@"3"]) { // 未开放 未付费
        [self performSegueWithIdentifier:@"BJobPrice" sender:nil];
    } else if ([self.model.status isEqualToString:@"4"]) { // 未开放 付费未认证
        [UserManager.share requestAuth:^(NSString * _Nonnull token, NSString * _Nonnull ticketid, FaceCallBack  _Nonnull faceCallBack) {
            [UserManager start:token rpCompleted:^(AUDIT auditState) {
                faceCallBack();
            }withVC:self.navigationController];
        } complete:^{
            [self request];
        }];
    } else if ([self.model.status isEqualToString:@"0"]) {
        [BJobListVM requestChangeStatus:self.model.id type:[NSString stringWithFormat:@"%ld", self.type] status:@"1" complete:^(BOOL success) {
            [self request];
        }];
    }
}

- (IBAction)shareAction:(UIButton *)sender {
    [UserManager.share shareToWX:[NSString stringWithFormat:@"%ld", self.type] jobId:self.model.id];
}

- (IBAction)putdownAction:(UIButton *)sender {
    [BJobListVM requestChangeStatus:self.model.id type:[NSString stringWithFormat:@"%ld", self.type]  status:@"0" complete:^(BOOL success) {
        [self request];
    }];
}
- (IBAction)addressAction:(UIButton *)sender {
    C_MapViewController *VC = [C_MapViewController new];
    VC.addressName = self.model.address;
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BPostJob"]) {
        BPostJobViewController *vc = segue.destinationViewController;
        vc.viewModel.type = self.type;
        vc.viewModel.jobModel = self.model;
    }
}

@end
