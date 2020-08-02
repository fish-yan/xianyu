//
//  B_NewsViewController.m
//  XianYu
//
//  Created by lmh on 2019/6/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "B_NewsViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "XY_RCConversationViewController.h"

@interface B_NewsViewController () <RCIMUserInfoDataSource>

@end

@implementation B_NewsViewController

- (instancetype)init{
    if (self = [super init]) {
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadChatStatus];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.conversationListTableView.tableFooterView = [UIView new];
    [self setDisplayConversationTypeArray:@[@(ConversationType_PRIVATE)]];
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    XY_RCConversationViewController *VC = [[XY_RCConversationViewController alloc]init];
    VC.conversationType = model.conversationType;
    VC.targetId = model.targetId;
    VC.title = model.conversationTitle;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [[RCIM sharedRCIM]setUserInfoDataSource:self];
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion
{
    
}

- (void)loadChatStatus{
    NSInteger status = [RCIMClient sharedRCIMClient].getConnectionStatus;
    if (status != ConnectionStatus_Connected) {
        UserInfoModel *info = [UserManager share].infoModel;
        [[IMManager share] userImConnectWithUid:[NSString stringWithFormat:@"%@", UserManager.share.infoModel.uid] withName:info.name withPhoto:info.photourl];
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
