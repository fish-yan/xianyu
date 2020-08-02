//
//  NewsViewController.m
//  XianYu
//
//  Created by lmh on 2019/6/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_NewsViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "XY_RCConversationViewController.h"

@interface C_NewsViewController ()

@end

@implementation C_NewsViewController

- (instancetype)initWithDisplayConversationTypes:(NSArray *)displayConversationTypeArray collectionConversationType:(NSArray *)collectionConversationTypeArray{
    if (self = [super initWithDisplayConversationTypes:displayConversationTypeArray collectionConversationType:displayConversationTypeArray]) {
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadChatStatus];
    //设置需要显示哪些类型的会话
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
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion
{
    NSLog(@"---------");
}

- (void)loadChatStatus{
    NSInteger status = [RCIMClient sharedRCIMClient].getConnectionStatus;
    if (status != ConnectionStatus_Connected) {
        UserInfoModel *info = [UserManager share].infoModel;
        [[IMManager share] userImConnectWithUid:[NSString stringWithFormat:@"%@", info.uid] withName:info.name withPhoto:info.photourl];
    }
}


@end
