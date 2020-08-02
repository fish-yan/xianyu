//
//  IMManager.m
//  XianYu
//
//  Created by lmh on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "IMManager.h"
#import "XY_RCConversationViewController.h"

@implementation IMManager

static IMManager *share = nil;
+ (IMManager *)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[self alloc]init];
        //        manager.infoModel = [[UserInfoModel alloc]init];
        //        manager.currentCityModel = [[CityModel alloc]init];
    });
    return share;
}

- (void)userImConnectWithUid:(NSString *)uid withName:(NSString *)name withPhoto:(NSString *)photo
{
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    NSString *imToken = [UserManager share].infoModel.rongtoken;
    [[RCIM sharedRCIM] connectWithToken:imToken success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        RCUserInfo *info = [[RCUserInfo alloc]initWithUserId:userId name:[UserManager share].infoModel.name portrait:[UserManager share].infoModel.photourl];
        [[RCIM sharedRCIM] setCurrentUserInfo:info];
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        [RCIM sharedRCIM].enableSyncReadStatus = YES;


    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%d", status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}

//断开连接
- (void)loginOutRongYun
{
    [[RCIMClient sharedRCIMClient] logout];
}

- (void)connentJobid:(NSNumber *)jobid withJobType:(NSInteger)jobType viewController:(UIViewController *)viewController
{
    NSDictionary *params = @{
                             @"jobid":jobid,
                             @"jobtype":@(jobType)
                             };
    
    [[NetworkManager instance] sendReq:params pageUrl:@"applicationlinkup" urlVersion:nil endLoad:NO viewController:nil complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSDictionary *dict = [result[@"data"] firstObject];
            XY_RCConversationViewController *VC = [[XY_RCConversationViewController alloc]init];
            NSString *rongid = [NSString stringWithFormat:@"%@",dict[@"rongid"]];
            NSString *name = dict[@"name"];
            NSString *photo = dict[@"photo"];
            VC.title = name;
            VC.conversationType = ConversationType_PRIVATE;
            VC.targetId = rongid;
            VC.hidesBottomBarWhenPushed = YES;
            [viewController.navigationController pushViewController:VC animated:YES];
            
            
            RCUserInfo *info = [[RCUserInfo alloc]initWithUserId:rongid name:name portrait:photo];
            [[RCIM sharedRCIM] refreshUserInfoCache:info withUserId:rongid];
            
        }
        else
        {
            [ToastView presentToastWithin:[UIApplication sharedApplication].keyWindow withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}


- (void)contractToBWithUserId:(NSString *)jobid withViewController:(UIViewController *)viewController
{
    NSDictionary *params = @{
                             @"id":jobid,
                             };
    
    [[NetworkManager instance] sendReq:params pageUrl:@"recruitlinkup" urlVersion:nil endLoad:NO viewController:nil complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSDictionary *dict = [result[@"data"] firstObject];
            XY_RCConversationViewController *VC = [[XY_RCConversationViewController alloc]init];
            NSString *rongid = [NSString stringWithFormat:@"%@",dict[@"rongid"]];
            NSString *name = dict[@"name"];
            NSString *photo = dict[@"photo"];
            VC.title = name;
            VC.conversationType = ConversationType_PRIVATE;
            VC.targetId = rongid;
            VC.hidesBottomBarWhenPushed = YES;
            [viewController.navigationController pushViewController:VC animated:YES];
            RCUserInfo *info = [[RCUserInfo alloc]initWithUserId:rongid name:name portrait:photo];
            [[RCIM sharedRCIM] refreshUserInfoCache:info withUserId:rongid];
        }
        else
        {
            [ToastView presentToastWithin:[UIApplication sharedApplication].keyWindow withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}





@end
