#import "NetworkManager.h"
#import "DeviceName.h"
#import "ADTracking.h"
#import "OpenUDID.h"
#import "NetStates.h"
#import "SecurityHelper.h"
#import "DESUtils.h"
#import "AESUtility.h"
static NetworkManager *_instance;
@implementation NetworkManager
+(NetworkManager *)instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NetworkManager alloc]init];
    });
    return _instance;
}

+ (void)sendReq:(NSDictionary *)params pageUrl:(NSString *)pageUrl complete:(void(^)(id result))complete {
    [self sendReq:params pageUrl:pageUrl complete:complete failure:nil];
}

+ (void)sendReq:(NSDictionary *)params pageUrl:(NSString *)pageUrl isLoading:(BOOL)isLoading complete:(void(^)(id result))complete {
    [self sendReq:params pageUrl:pageUrl isLoading:YES complete:complete failure:nil];
}

+ (void)sendReq:(NSDictionary *)params pageUrl:(NSString *)pageUrl complete:(void(^)(id result))complete failure:(void(^)(NSInteger code, NSString *msg))failure {
    [self sendReq:params pageUrl:pageUrl isLoading:YES complete:complete failure:failure];
}

+ (void)sendReq:(NSDictionary *)params pageUrl:(NSString *)pageUrl isLoading:(BOOL)isLoading complete:(void(^)(id result))complete failure:(void(^)(NSInteger code, NSString *msg))failure {
    UIViewController *vc = [UIViewController visibleViewController];
    if (isLoading) {
        [SVProgressHUD show];
    }
    NSLog(@"%@--\nparams=%@", pageUrl, [params JSONString]);
    [[NetworkManager instance] sendReq:params pageUrl:pageUrl urlVersion:nil endLoad:NO viewController:vc complete:^(id result, int successCode, NSString *errowMessage) {
        if (isLoading) {
            [SVProgressHUD dismiss];
        }
        NSLog(@"%@--\nresult=%@", pageUrl, [result JSONString]);
        if (successCode == 0) {
            complete(result);
        } else {
            !failure ?: failure(successCode, errowMessage);
            [ToastView presentToastWithin:vc.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        NSLog(@"%@--\nerror=%@", pageUrl, error);
        NSError *e = (NSError *)error;
        !failure ?: failure(e.code, e.localizedDescription);
        if (isLoading) {
            [SVProgressHUD dismiss];
        }
    }];
}

- (void)sendReq:(NSDictionary *)params pageUrl:(NSString *)pageUrl urlVersion:(NSString *)version   endLoad:(BOOL)isEnd viewController:(UIViewController *)viewController complete:(CompleteBlock)complete errorBlock:(ErrorBlock)errorBlock
{
    NSDictionary *viewDict = nil;
    if (viewController && viewController != nil) {
        viewDict = @{
                     @"viewControl":viewController,
                     };
    }
    if (![self checkNetworkStatus]) {
//        [CommanTool removeViewType:4 parentView:viewController.view];
//        [[NSNotificationCenter defaultCenter] postNotificationName:NetErrorLoadFailure object:self userInfo:viewDict];
        complete(nil,10000,@"没有网络");
        [SVProgressHUD dismiss];
        return;
    }
    else
    {
        NSString *versionStr = nil;
        if (version == nil) {
            versionStr = @"1";
        }
        else
        {
            versionStr = version;
        }
        NSMutableDictionary *mDic = [self setRequestPubicPrames:params needLog:YES];
        [mDic setObject:pageUrl forKey:@"code"];
        [mDic setObject:versionStr forKey:@"ver"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
        [manager POST:XY_URL parameters:mDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSString *errorCode = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            NSString *extra = responseObject[@"extra"];
            NSString *codeMessage = responseObject[@"msg"];
            if ([errorCode integerValue] == 0) {
                //移除刷新界面
                if (viewController.view && viewController.view != nil) {
//                    [CommanTool removeViewType:2 parentView:viewController.view];
                }
                if (isEnd) {
//                    [CommanTool removeViewType:1 parentView:viewController.view];
                }
                complete(responseObject, [errorCode intValue],codeMessage);
            }
            else
            {
                if ([errorCode isEqualToString:App_ResponeCode_TimestampExpires]) {
                    NSString *str = [NSString stringWithFormat:@"%lld",(long long)time(NULL)];
                    long long timeCount = [extra longLongValue] - [str longLongValue];
                    [[NSUserDefaults standardUserDefaults] setObject:@(timeCount) forKey:@"APP_ServiceTime"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self sendReq:params pageUrl:pageUrl urlVersion:XY_URL endLoad:isEnd viewController:viewController  complete:complete errorBlock:errorBlock];
                }
                //token过期  token失效
                else if ([errorCode isEqualToString:App_ResponeCode_InvalidToken] || [errorCode isEqualToString:App_ResponeCode_OverdueToken])
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NetErrorTokenToLoginViewController object:nil];
                }
                else
                {
                    if (isEnd) {
//                        [CommanTool removeViewType:1 parentView:viewController.view];
                    }
                    if (viewController.view && viewController.view != nil) {
//                        [CommanTool removeViewType:2 parentView:viewController.view];
                    }
                    complete(responseObject, [errorCode intValue],codeMessage);
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
//            [CommanTool removeViewType:4 parentView:viewController.view];
            [[NSNotificationCenter defaultCenter] postNotificationName:NetErrorLoadFailure object:self userInfo:viewDict];
            [SVProgressHUD dismiss];
        }];
    }
}

- (NSMutableDictionary *)setRequestPubicPrames:(NSDictionary *)pamram needLog:(BOOL)isLog{
    NSMutableDictionary * newPrames = [NSMutableDictionary new];
    // NOTE: appid
    [newPrames setObject:XY_APPID forKey:@"appid"];
    // NOTE: app 版本号
    NSString * appversion = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [newPrames setObject:appversion forKey:@"appv"];
    // NOTE: app平台  native:原生
    [newPrames setObject:@"nt" forKey:@"appm"];
    // NOTE: app渠道 ios固定为appstore
    [newPrames setObject:@"appstore" forKey:@"appch"];
    // NOTE: 以广告标示符为主，如果标示符为空 则使用openudid 作为设备id
//    NSString * didString = INCASE_EMPTY([[ADTracking instance] idfaString], [OpenUDID value]);
//    [newPrames setObject:didString forKey:@"did"];
    // NOTE: 设备品牌 "iphone ipodtocu"
    [newPrames setObject:[UIDevice currentDevice].model forKey:@"dbr"];
    // NOTE: 设备型号
    [newPrames setObject:[DeviceName getCurrentDeviceModel] forKey:@"dmd"];
    // NOTE: 设备os
    [newPrames setObject:[UIDevice currentDevice].systemName forKey:@"dos"];
    // NOTE: 设备宽高
    NSString * screenBunds = [NSString stringWithFormat:@"%d*%d",(int)KScreenWidth,(int)KScreenHeight];
    [newPrames setObject:screenBunds forKey:@"dscr"];
    // NOTE: 设备网络类型
    [newPrames setObject:[NetStates getCurrentNetStates] forKey:@"dnet"];
    double lat = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lat"] doubleValue];
    double lng = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lng"] doubleValue];
    // NOTE: 纬度
    if (lat != 0) {
        [newPrames setObject:[NSString stringWithFormat:@"%f",lat] forKey:@"lat"];
    }
    else
    {
        [newPrames setObject:@"0" forKey:@"lat"];
    }
    // NOTE: 经度
    if (lng != 0) {
        [newPrames setObject:[NSString stringWithFormat:@"%f",lng] forKey:@"lng"];
    }
    else
    {
        [newPrames setObject:@"0" forKey:@"lng"];
    }
    // NOTE: pamram 转化为JsonStr ->DES加密 -> base64的字符串
    // NOTE: 转json
    NSString * bodyStr = [pamram JSONString];
    NSString *string3 = [DESUtils encodeUrlString:bodyStr];
    //    [NSString stringWithContentsOfURL:[NSURL URLWithString:bodyStr] encoding:NSUTF8StringEncoding error:nil];
    // NOTE: jsonstr  encode
    NSString * bodyStr1 = [AESUtility AES256EncrypeKey:AES_Body_Key contentText:string3];
    NSString *bodyStr2 = [DESUtils base64StringFromBase64UrlEncodedString:bodyStr1];
    [newPrames setObject:bodyStr2 forKey:@"body"];
    // NOTE: 时间戳
    NSInteger timeCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"APP_ServiceTime"] integerValue];
    long long currentTime = (long long)time(NULL) + (long long)timeCount;
    [newPrames setObject:[NSString stringWithFormat:@"%lld",currentTime] forKey:@"ts"];
    // NOTE: 是否需要登陆， 登陆需带token
    NSString * tokenStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [newPrames setValue:tokenStr forKey:@"token"];
    // NOTE: sign 所有参数 -> 排序拼接为字符串 --> md5 字符串
    // NOTE: 排序
    NSArray * array = [SecurityHelper sortString:newPrames.allKeys];
    // NOTE: 拼接value
    NSString * paramValue = [SecurityHelper montage:newPrames keys:array];
    // NOTE: 对paramValue 拼接 加上 md5key后 再进行签名
    NSString * keyString = [NSString stringWithFormat:@"%@%@",paramValue,MD5_Key];
    // NOTE: md5 转换
    NSString * signStr = [keyString MD5Hash];
    [newPrames setObject:signStr forKey:@"sign"];
    //    [newPrames setObject:version forKey:@"ver"];
    return newPrames;
}

-(BOOL)checkNetworkStatus
{
    //     2.检测手机是否能上网络
    Reachability *connect = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus netStatus = [connect currentReachabilityStatus];
    if (netStatus == NotReachable) {
        return NO;
    }
    else if (netStatus ==ReachableViaWiFi || netStatus == ReachableViaWWAN)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
