//
//  XY_RCConversationViewController.m
//  XianYu
//
//  Created by lmh on 2019/7/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "XY_RCConversationViewController.h"
#import <IQKeyboardManager.h>
#import "ChatHeaderCell.h"
#import "C_News_JobInfoModel.h"
#import "C_News_JobView.h"
#import "B_News_ResumeModel.h"
#import "B_News_ResumeView.h"
#import "C_PartJobInfoViewController.h"
#import "C_JobInfoViewController.h"
#import "BResumeDetailViewController.h"
#import "BJobDetailViewController.h"

@interface XY_RCConversationViewController ()

@property (nonatomic, strong) C_News_JobInfoModel *currentJobModel;

@property (nonatomic, strong) B_News_ResumeModel *currentResumeModel;

@property (nonatomic, assign) XY_News_IdenfifierType identifierType;

@property (nonatomic, strong) NSString *resumeID;

@property (nonatomic, strong) B_News_ResumeView *resumeView;

@property (nonatomic, strong) C_News_JobView *jobView;

@property(nonatomic, assign) NSInteger blackstatus;

@end

@implementation XY_RCConversationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    UserInfoModel *myModel = [UserManager share].infoModel;
    RCUserInfo *info = [[RCUserInfo alloc]initWithUserId:[NSString stringWithFormat:@"%@",myModel.uid] name:myModel.name portrait:myModel.photourl];
    [[RCIM sharedRCIM]refreshUserInfoCache:info withUserId:[NSString stringWithFormat:@"%@",myModel.uid]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_Ground_F5F5F5;
    [self createNavRightItem];
    [self loadResumeInfoData];
}

- (void)createBoardView
{
    //    删除指定位置的方法：
    [self.chatSessionInputBarControl.pluginBoardView removeItemAtIndex:2];
    //    删除指定标签的方法：
    [self.chatSessionInputBarControl.pluginBoardView removeItemWithTag:102];
}


- (void)createNavRightItem
{
    NSDictionary *params = @{
                             @"rongid":[UserManager share].infoModel.rongid,
                             @"brongid":self.targetId
                             };
    [[NetworkManager instance] sendReq:params pageUrl:@"userblack" urlVersion:nil endLoad:NO viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSDictionary *dict = [result[@"data"] firstObject];
            self.blackstatus = [dict[@"blackstatus"] intValue];
            if (self.blackstatus == 0 || self.blackstatus == 2) {
                UIBarButtonItem *items =[[UIBarButtonItem alloc]initWithTitle:@"屏蔽" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickOneRightNavBarItem)];
                items.tintColor = Color_Black_464646;
//                items.enabled = isEnable;
                self.navigationItem.rightBarButtonItem = items;
            }
            else
            {
                UIBarButtonItem *items =[[UIBarButtonItem alloc]initWithTitle:@"已屏蔽" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickOneRightNavBarItem)];
                items.tintColor = Color_Black_464646;
//                items.enabled = isEnable;
                self.navigationItem.rightBarButtonItem = items;
            }
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}

- (void)clickOneRightNavBarItem
{
    if (self.blackstatus == 0 || self.blackstatus == 2) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"确定屏蔽此用户的信息吗？" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            NSDictionary *params = @{
                                     @"rongid":[UserManager share].infoModel.rongid,
                                     @"brongid":self.targetId
                                     };
            [[NetworkManager instance] sendReq:params pageUrl:@"adduserblack" urlVersion:nil endLoad:NO viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
                if (successCode == 0) {
                    [self createNavRightItem];
                }
                else
                {
                    [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
                }
            } errorBlock:^(id error) {
                
            }];
        }];
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    else
    {
        NSDictionary *params = @{
                                 @"rongid":[UserManager share].infoModel.rongid,
                                 @"brongid":self.targetId
                                 };
        [[NetworkManager instance] sendReq:params pageUrl:@"deluserblack" urlVersion:nil endLoad:NO viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
            if (successCode == 0) {
                [self createNavRightItem];
            }
            else
            {
                [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
            }
        } errorBlock:^(id error) {
            
        }];
    }
    
}

- (void)loadJobData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.identifierType == XY_News_IdenfifierType_B) {
        [params setValue:[UserManager share].infoModel.rongid forKey:@"rongid"];
        [params setValue:self.targetId forKey:@"myrongid"];
    }
    else if (self.identifierType == XY_News_IdenfifierType_C)
    {
        [params setValue:self.targetId forKey:@"rongid"];
        [params setValue:[UserManager share].infoModel.rongid forKey:@"myrongid"];
    }
   
    if ([UserManager share].latitude > 0) {
        [params setObject:@([UserManager share].latitude) forKey:@"lad"];
    }
    else
    {
        [params setObject:@"" forKey:@"lad"];
    }
    
    if ([UserManager share].longitude > 0) {
        [params setObject:@([UserManager share].longitude) forKey:@"lon"];
    }
    else
    {
        [params setObject:@"" forKey:@"lon"];
    }
    [[NetworkManager instance] sendReq:params pageUrl:@"getlastjob" urlVersion:nil endLoad:NO viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSDictionary *dict = [result[@"data"] firstObject];
            C_News_JobInfoModel *model = [[C_News_JobInfoModel alloc]initWithModelDict:dict];
            self.currentJobModel = model;
            if (self.identifierType != XY_News_IdenfifierType_B) {
                [self createJobView];
            }
            else
            {
                [self createResumeView];
            }
            
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}


- (void)loadResumeInfoData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.targetId forKey:@"id"];

    [[NetworkManager instance] sendReq:params pageUrl:@"getresumebyrongid" urlVersion:nil endLoad:NO viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSDictionary *dict = [result[@"data"] firstObject];
            B_News_ResumeModel *model = [[B_News_ResumeModel alloc]initWithModelDict:dict];
            self.currentResumeModel = model;
            if ([self.currentResumeModel.identity isEqualToString:@"applicants"]) {
                self.identifierType = XY_News_IdenfifierType_B;
                [self loadJobData];
                [self loadResumeID];
                [self createResumeView];
            }
            //应聘者
            else if ([self.currentResumeModel.identity isEqualToString:@"recruiter"])
            {
                self.identifierType = XY_News_IdenfifierType_C;
                [self loadJobData];
//                [self createJobView];
            }
            
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}


- (void)createJobView
{
    self.jobView = [[C_News_JobView alloc]initWithFrame:(CGRectMake(Anno750(24), Anno750(20) + NavRectHeight, KScreenWidth - Anno750(48), Anno750(250)))];
    [[self.jobView.clickButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //全职
        if (self.currentJobModel.jobtype == 0) {
            C_JobInfoViewController *VC = [C_JobInfoViewController new];
            VC.jobId = self.currentJobModel.id;
            VC.cityModel = [UserManager share].currentFullJobCityModel;
            [self.navigationController pushViewController:VC animated:YES];
        }
        else if (self.currentJobModel.jobtype == 1)
        {
            C_PartJobInfoViewController *VC = [C_PartJobInfoViewController new];
            VC.jobID = self.currentJobModel.id;
            VC.cityModel = [UserManager share].currentPartJobCityModel;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }];
    [self.view addSubview:self.jobView];
    [self.jobView configureWithModel:self.currentJobModel];
    if (self.identifierType == XY_News_IdenfifierType_C) {
        self.conversationMessageCollectionView.frame = CGRectMake(0, NavRectHeight + Anno750(20) + Anno750(250), KScreenWidth, KScreenHeight - (NavRectHeight + Anno750(20) + Anno750(250)));
    }
}

- (void)createResumeView
{
    [self.jobView removeFromSuperview];
    if (self.resumeView && self.resumeView == nil) {
        [self.resumeView removeFromSuperview];
        self.resumeView = nil;
    }
    self.resumeView = [[B_News_ResumeView alloc]initWithFrame:(CGRectMake(Anno750(24), Anno750(20) + NavRectHeight, KScreenWidth - Anno750(48), Anno750(350)))];
    [[self.resumeView.jobButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.currentJobModel.jobtype == 0) {
            if (XY_News_IdenfifierType_B == self.identifierType) {
                BJobDetailViewController *vc = [[UIStoryboard storyboardWithName:@"BJob" bundle:nil] instantiateViewControllerWithIdentifier:@"BJobDetailViewController"];
                vc.type = 0;//0:全职，1：兼职
                vc.jobId = [NSString stringWithFormat:@"%@", self.currentJobModel.id]; // jobID
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                C_JobInfoViewController *VC = [C_JobInfoViewController new];
                VC.jobId = self.currentJobModel.id;
                VC.cityModel = [UserManager share].currentFullJobCityModel;
                [self.navigationController pushViewController:VC animated:YES];
            }
        }
        else
        {
            if (XY_News_IdenfifierType_B == self.identifierType) {
                BJobDetailViewController *vc = [[UIStoryboard storyboardWithName:@"BJob" bundle:nil] instantiateViewControllerWithIdentifier:@"BJobDetailViewController"];
                vc.type = 1;//0:全职，1：兼职
                vc.jobId = [NSString stringWithFormat:@"%@", self.currentJobModel.id]; // jobID
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                C_PartJobInfoViewController *VC = [C_PartJobInfoViewController new];
                VC.jobID = self.currentJobModel.id;
                VC.cityModel = [UserManager share].currentPartJobCityModel;
                [self.navigationController pushViewController:VC animated:YES];
            }
        }
    }];
    [self.view addSubview:self.resumeView];
    [self.resumeView configureWithModel:self.currentResumeModel with:self.currentJobModel];
    if (self.identifierType == XY_News_IdenfifierType_B) {
        self.conversationMessageCollectionView.frame = CGRectMake(0, NavRectHeight + Anno750(20) + Anno750(350), KScreenWidth, KScreenHeight - (NavRectHeight + Anno750(20) + Anno750(350)));
    }
}

- (void)loadResumeID
{
    NSDictionary *params = @{@"id":self.targetId};
    [[NetworkManager instance] sendReq:params pageUrl:@"getresumedetailedbyrongid" urlVersion:nil endLoad:NO viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSDictionary *dict = [result[@"data"] firstObject];
            NSString *resumeID = dict[@"id"];
            self.resumeID = resumeID;
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
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

@end
