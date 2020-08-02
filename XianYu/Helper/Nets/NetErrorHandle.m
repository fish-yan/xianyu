//
//  NetErrorHandle.m
//  New_MeiChai
//
//  Created by lmh on 2018/6/26.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "NetErrorHandle.h"
#import "LoginViewController.h"

@implementation NetErrorHandle

static NetErrorHandle *manager = nil;
+ (NetErrorHandle *)defaultHandle
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetErrorHandle alloc]init];
    });
    return manager;
}

- (void)registerNotification{
    //跳转登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popLoginViewController) name:NetErrorTokenToLoginViewController object:nil];
    //无网络
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFailurView:) name:NetErrorLoadFailure object:nil];

}

- (void)popLoginViewController
{
//    [UserManager shareManager].infoModel = nil;
//    [UserManager shareManager].infoModel.token = nil;
    UserManager.share.token = @"";
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *NVC = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
    [UIApplication sharedApplication].keyWindow.rootViewController = NVC;
    
}

- (void)loadFailurView:(NSNotification *)noti
{
    NSDictionary *dict =  noti.userInfo;
    if ([dict allKeys].count > 0) {
        UIViewController *viewController = [dict objectForKey:@"viewControl"];
        if (viewController && viewController != nil) {
//            [CommanTool addError:nil inView:viewController.view];
        }
    }
}

- (void)removeAllNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NetErrorTokenToLoginViewController object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NetErrorLoadFailure object:nil];
}


@end
