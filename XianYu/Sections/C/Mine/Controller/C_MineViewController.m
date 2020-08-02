//
//  MineViewController.m
//  XianYu
//
//  Created by lmh on 2019/6/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_MineViewController.h"
#import "C_MineLIstCell.h"
#import "C_MineHeaderView.h"
#import "C_Mine_ResumeViewController.h"
#import "CMResumeViewController.h"
#import "C_Mine_DeliveryJobViewController.h"
#import "C_Mine_SetViewController.h"
#import "C_Mine_EditInfoViewController.h"
#import "BaseFuncViewController.h"
#import "BRInfoViewController.h"
#import "BJobPriceViewController.h"

@interface C_MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) C_MineHeaderView *headView;

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) NSArray *nameArray;

@property (nonatomic, strong) UserInfoModel *currentModel;


@end

@implementation C_MineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
   self.tabBarController.tabBar.hidden = NO;
    
    [UserManager.share loadUserInfoData:XYC block:^(int code) {
        self.currentModel = [UserManager share].infoModel;
        self.headView.nameLabel.text = self.currentModel.name;
        self.headView.summaryLabel.text = [NSString stringWithFormat:@"今日已投递%@份简历", self.currentModel.deliverynum];
        self.headView.chateCountLabel.text = [NSString stringWithFormat:@"今日已沟通%@人", self.currentModel.linkupnum];
        [self.headView.headImageView sd_setImageWithURL:[NSURL URLWithString:self.currentModel.photourl] placeholderImage:nil];
        [self.tableView reloadData];
    } withConnect:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.imageArray = @[@"icon_c_mine_resume", @"icon_c_mine_delivery",  @"icon_c_mine_zhaoren", @"icon_c_mine_set", @"icon_c_mine_help",];
    self.nameArray = @[@"我的简历", @"投递岗位", @"切换为招聘者", @"设置",@"联系我们"];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight)) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 0.0001f;
    self.tableView.sectionHeaderHeight = 0.0001f;
   
    [self.view addSubview:self.tableView];
    [self createTableHeadView];
}

- (void)createTableHeadView
{
    self.headView = [[C_MineHeaderView alloc]initWithFrame:(CGRectMake(0, 0, KScreenWidth, Anno750(320)))];
//    [[self.headView.clickButon rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        C_Mine_EditInfoViewController *VC = [C_Mine_EditInfoViewController new];
//        [self createViewWithController:VC andNavType:YES andLoginType:YES];
//    }];
    self.tableView.tableHeaderView = self.headView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier_list = @"listCell";
    C_MineLIstCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_list];
    if (!cell) {
        cell = [[C_MineLIstCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_list];
    }
    [cell configureWithImageStr:self.imageArray[indexPath.row] withNameStr:self.nameArray[indexPath.row]];
    if ([self.nameArray[indexPath.row] isEqual:@"我的简历"]) {
        cell.progressLab.hidden = NO;
        NSString *str = [UserManager share].infoModel.percentage;
        if (!str || str.length == 0) {
            str = @"0%";
        }
        cell.progressLab.text = [NSString stringWithFormat:@"简历完成%@", str];
    } else {
        cell.progressLab.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CMResumeViewController *vc = [[UIStoryboard storyboardWithName:@"CMine" bundle:nil] instantiateViewControllerWithIdentifier:@"CMResumeViewController"];
        [self.navigationController pushViewController:vc animated:YES];
//        C_Mine_ResumeViewController *VC = [C_Mine_ResumeViewController new];
//        [self createViewWithController:VC andNavType:YES andLoginType:YES];
    }
    else if (indexPath.row == 1)
    {
        C_Mine_DeliveryJobViewController *VC = [C_Mine_DeliveryJobViewController new];
        [self createViewWithController:VC andNavType:YES andLoginType:YES];
    }
    else if (indexPath.row == 2)
    {
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
                [self.navigationController pushViewController:vc animated:YES];
            }
        } withConnect:YES];
        
    }
    else if (indexPath.row == 3)
    {
        C_Mine_SetViewController *VC = [C_Mine_SetViewController new];
        [self createViewWithController:VC andNavType:YES andLoginType:YES];
    } else {

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
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Anno750(110);
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
