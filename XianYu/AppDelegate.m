//
//  AppDelegate.m
//  XianYu
//
//  Created by lmh on 2019/6/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "AppDelegate.h"
#import <Bugly/Bugly.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import "C_RootViewController.h"
#import "LoginViewController.h"
#import "BaseFuncViewController.h"
#import "OSSManager.h"
//#import <RPSDK/RPSDK.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "BRInfoViewController.h"
#import "C_Regist_EditUserInfoViewController.h"
#import "ADViewController.h"
#import "NetErrorHandle.h"
//#import <RPSDK/RPSDK.h>
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import "XY_RCConversationViewController.h"
#import <UMShare/UMSocialManager.h>

@interface AppDelegate ()<AMapLocationManagerDelegate, JPUSHRegisterDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;

@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NetErrorHandle defaultHandle] registerNotification];
//    [self checkAppUpdate];
//    [RPSDK initialize:RPSDKEnvOnline];
    //高德地图设置
    [[AMapServices sharedServices] setEnableHTTPS:NO];
    [AMapServices sharedServices].apiKey = @"87eaccb4324fbba2c3c5f3f36e33b8bc";
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAPPID appSecret:@"" redirectURL:nil];

    [[RCIM sharedRCIM] initWithAppKey:@"8brlm7uf8i7a3"];
//    [RPSDK initialize:RPSDKEnvOnline];
//    [[OSSManager share] uploadImage:nil];
//    [[UserManager manager] loadCityModel];

//    [RPSDK initialize:RPSDKEnvOnline]; //必须为RPSDKEnvOnline
    
    
    
    [[UserManager share] loadProvice];
    [UserManager.share loadJobList];
    [UserManager.share loadPartJobList];
    [self configureWithUMPush:launchOptions];

    self.window.backgroundColor = Color_White;
    [Bugly startWithAppId:XianYu_Bugly_Id];
    [UMConfigure initWithAppkey:XianYu_Um_Key channel:@"App Store"];
    [MobClick setScenarioType:E_UM_NORMAL];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    self.window.rootViewController = [C_RootViewController new];
    
    if (UserManager.share.token.length > 0) {

        self.window.rootViewController = [ADViewController new];

    }
    else
    {
        self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
    }
    
    NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo != nil) {
        NSDictionary *myDict = userInfo;
        NSDictionary *dict = myDict[@"rc"];
        RCUserInfo *info = [[RCIM sharedRCIM] getUserInfoCache:dict[@"fId"]];
        
        XY_RCConversationViewController *VC = [[XY_RCConversationViewController alloc]init];
        VC.targetId = info.userId;
        VC.title = info.name;
        VC.conversationType = ConversationType_PRIVATE;
        [[self getCurrentVC] pushViewController:VC animated:YES];
    }

    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark ------- 检查更新 --------
- (void)checkAppUpdate
{
    NSDictionary *params = @{
                             @"appid":@"10002",
                             @"version":[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"]
                             };
    
    [[NetworkManager instance] sendReq:params pageUrl:@"" urlVersion:nil endLoad:NO viewController:nil complete:^(id result, int successCode, NSString *errowMessage) {
        if(successCode == 0)
        {
            NSDictionary *dict = [result[@"data"] firstObject];
            NSString *version = dict[@"version"];
            NSString *releasenote = dict[@"releasenote"];
            NSString *releasedate = dict[@"releasedate"];
            NSString *updatecmd = dict[@"updatecmd"];
            NSString *newversion = dict[@"newversion"];
            NSString *newnote = dict[@"newnote"];
            NSString *newdate = dict[@"newdate"];
            NSString *downloadurl = dict[@"downloadurl"];
            //            updatecmd = @"suggest";
            //不更新
            if ([updatecmd isEqualToString:@"no"]) {
                
            }
            //简易更新
            else if ([updatecmd isEqualToString:@"suggest"])
            {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"更新提示" message:newnote preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"知道了" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"更新" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downloadurl]];
                }];
                [alertVC addAction:action1];
                [alertVC addAction:action2];
                [self.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
            }
            //强制更新
            else if ([updatecmd isEqualToString:@"must"])
            {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"更新提示" message:newnote preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"去更新" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downloadurl]];
                }];
                //itms-apps://itunes.apple.com/app/id1343044119
                [alertVC addAction:action1];
                [self.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
            }
        }
        else
        {
            [ToastView presentToastWithin:self.window withIcon:(APToastIconNone) text:errowMessage duration:3.0f];
        }
    } errorBlock:^(id error) {
        
    }];
   
}


#pragma mark ----------- 友盟推送 ----------
//注册友盟推送
- (void)configureWithUMPush:(NSDictionary *)launchOptions
{
    [JPUSHService setBadge:0];
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //iOS10必须加下面这段代码。
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate=self;
        UNAuthorizationOptions types10=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //点击允许
                
            } else {
                //点击不允许
            }
        }];
        //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
        if (([[[UIDevice currentDevice] systemVersion]intValue]>=8)&&([[[UIDevice currentDevice] systemVersion]intValue]<10)) {
            UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
            action1.identifier = @"action1_identifier";
            action1.title=@"打开应用";
            action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
            UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
            action2.identifier = @"action2_identifier";
            action2.title=@"忽略";
            action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
            action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
            action2.destructive = YES;
            UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
            actionCategory1.identifier = @"category1";//这组动作的唯一标示
            [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
            NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
            //        [UMessage registerForRemoteNotifications:categories];
            entity.categories = categories;
        }
        //如果要在iOS10显示交互式的通知，必须注意实现以下代码
        if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
            UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_ios10_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
            UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_ios10_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
            //UNNotificationCategoryOptionNone
            //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
            //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
            UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category101" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
            NSSet *categories_ios10 = [NSSet setWithObjects:category1_ios10, nil];
            //            [center setNotificationCategories:categories_ios10];
            entity.categories = categories_ios10;
            
        }
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:@"c6142040085fd5d8a03b5e9b" channel:@"App Store" apsForProduction:YES];
    //如果对角标，文字和声音的取舍，请用下面的方法
    //UIRemoteNotificationType types7 = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
    //UIUserNotificationType types8 = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
    //[UMessage registerForRemoteNotifications:categories withTypesForIos7:types7 withTypesForIos8:types8];
    //for log
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    //    [UMessage registerDeviceToken:deviceToken];
    NSString *deviceTokenString2 = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                     stringByReplacingOccurrencesOfString:@">" withString:@""]
                                    stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"方式2：%@", deviceTokenString2);
    NSString *deveiveStr = [JPUSHService registrationID];
    NSUserDefaults *standDefault = [NSUserDefaults standardUserDefaults];
    //    [standDefault setValue:deveiveStr forKey:@"deviceToken"];
    [standDefault setValue:deveiveStr forKeyPath:@"App_DeviceToken"];
    [standDefault synchronize];
    [JPUSHService registerDeviceToken:deviceToken];
    NSLog(@"-----------%@", [JPUSHService registrationID]);
    //    NSString *sss = [[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"];
    NSLog(@"==============");
    //        [[UserManager manager] bindPush];
    NSLog(@"--------");
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0)
{
    NSUserDefaults *defaultsDevice = [NSUserDefaults standardUserDefaults];
    [defaultsDevice setValue:nil forKey:@"deviceToken"];
    [defaultsDevice synchronize];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (UINavigationController *)getCurrentVC
{
    UINavigationController *tbc = (UINavigationController *)self.window.rootViewController;
    return tbc;
}





@end
