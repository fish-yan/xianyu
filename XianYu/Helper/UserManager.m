//
//  UserManager.m
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "UserManager.h"
#import "AreaModel.h"
#import "LoginViewController.h"

#import <CoreLocation/CLLocationManager.h>

#import "XianYu-Swift.h"
#import "PrefixHeader.pch"


@implementation UserManager



static UserManager *manager = nil;
+ (UserManager *)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (void)setToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
}

- (NSString *)token {
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    return str ?: @"";
}

- (void)setRongtoken:(NSString *)rongtoken {
    [[NSUserDefaults standardUserDefaults] setObject:rongtoken forKey:@"rongtoken"];
}

- (NSString *)rongtoken {
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"rongtoken"];
    return str ?: @"";
}
//
//- (void)setName:(NSString *)name {
//    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
//}
//
//- (NSString *)name {
//    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
//    return str ?: @"";
//}
//
//- (void)setPhoto:(NSString *)photo {
//    [[NSUserDefaults standardUserDefaults] setObject:photo forKey:@"photo"];
//}
//
//- (NSString *)photo {
//    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"photo"];
//    return str ?: @"";
//}
//
//- (void)setSex:(NSString *)sex {
//    [[NSUserDefaults standardUserDefaults] setObject:sex forKey:@"sex"];
//}
//
//- (NSString *)sex {
//    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"sex"];
//    return str ?: @"";
//}

- (void)setLoginclient:(NSString *)loginclient {
    
    [[NSUserDefaults standardUserDefaults] setObject:loginclient forKey:@"loginclient"];
}

- (NSString *)loginclient {
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginclient"];
    return str ?: @"";
}

- (NSMutableArray<ProvinceModel *> *)provinceList {
    if (!_provinceList) {
        _provinceList = [NSMutableArray array];
    }
    return _provinceList;
}

- (NSMutableArray<JobTypeModel *> *)jobList {
    if (!_jobList) {
        _jobList = [NSMutableArray array];
    }
    return _jobList;
}

- (NSMutableArray<JobDetailModel *> *)partJobList {
    if ((!_partJobList)) {
        _partJobList = [NSMutableArray array];
    }
    return _partJobList;
}

- (void)loadProvice {
    dispatch_queue_t queue = dispatch_queue_create("load_address", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [self resolutionWithLocalCity];
    });
}

- (void)loadJobList {
    dispatch_queue_t queue = dispatch_queue_create("load_job_list", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [self resoluLocalFullJobType];
    });
}

- (void)loadPartJobList {
    dispatch_queue_t queue = dispatch_queue_create("load_part_job_list", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [self resoluLocalPartJobType];
    });
}

- (NSArray *)loadLocalCityData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        //DLog(@"JSON解码失败");
        return nil;
    } else {
        return jsonObj;
    }
}

- (void)resolutionWithLocalCity
{
    
    NSArray *array = [self loadLocalCityData];
    for (NSDictionary *firstDict in array) {
        ProvinceModel *proModel = [ProvinceModel yy_modelWithJSON:firstDict];
        NSArray *secondArray = firstDict[@"lowerlevel"];
        for (NSDictionary *secondDict in secondArray) {
            CityModel *cityModel = [CityModel yy_modelWithJSON:secondDict];
            NSArray *thirdArray = secondDict[@"lowerlevel"];
            for (NSDictionary *thirdDict in thirdArray) {
                AreaModel *areaModel = [AreaModel yy_modelWithJSON:thirdDict];
                NSArray *fourArray = thirdDict[@"lowerlevel"];
                for (NSDictionary *fourDict in fourArray) {
                    StreetModel *streetModel = [StreetModel yy_modelWithJSON:fourDict];
                    [areaModel.streetList addObject:streetModel];
                }
                [cityModel.areaList addObject:areaModel];
            }
            [proModel.cityList addObject:cityModel];
        }
        [self.provinceList addObject:proModel];
    }
    NSLog(@"complete");
}



- (NSDictionary *)loadLocalCityAllData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        //DLog(@"JSON解码失败");
        return nil;
    } else {
        return jsonObj;
    }
}

- (NSArray *)loadLocalFullJobType
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fullpost" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        //DLog(@"JSON解码失败");
        return nil;
    } else {
        return jsonObj;
    }
}

- (void)resoluLocalFullJobType
{
    NSArray *array = [self loadLocalFullJobType];
    for (NSDictionary *dict in array) {
        JobTypeModel *typeModel = [JobTypeModel yy_modelWithJSON:dict];
        for (NSDictionary *subDict in dict[@"lowerLevel"]) {
            JobDetailModel *model = [JobDetailModel yy_modelWithJSON:subDict];
            [typeModel.detailList addObject:model];
        }
        [self.jobList addObject:typeModel];
    }
}


- (NSArray *)loadLocalPartJobType
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"partpost" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        //DLog(@"JSON解码失败");
        return nil;
    } else {
        return jsonObj[@"RECORDS"];;
    }
}

- (void)resoluLocalPartJobType
{
    NSArray *array = [self loadLocalPartJobType];
    for (NSDictionary *dict in array) {
        JobDetailModel *typeModel = [JobDetailModel yy_modelWithJSON:dict];
        [self.partJobList addObject:typeModel];
    }
}

- (NSDictionary *)loadLocalJobType
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"job" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        //DLog(@"JSON解码失败");
        return nil;
    } else {
        return jsonObj;
    }
}

//获取职位列表
- (NSArray *)resoluLocalJobType
{
    NSDictionary *dict = [self loadLocalJobType];
    NSArray *array = dict[@"RECORDS"];
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        JobTypeModel *model = [[JobTypeModel alloc]initWithModelDict:dict];
        [mArray addObject:model];
    }
    return mArray;
}

// 替换招聘者应聘者角色
- (void)switchClient:(XYLoginclient)client complete:(void(^_Nullable)(void) )complete {
    NSString *str = client == XYC ? @"1" : @"0";
    [NetworkManager sendReq:@{@"loginclient":str} pageUrl:XY_B_switchclient complete:^(id result) {
        UserManager.share.loginclient = str;
        NSInteger status = [RCIMClient.sharedRCIMClient getConnectionStatus];
        if (status == ConnectionStatus_Connected) {
            [IMManager.share loginOutRongYun];
        }
        [IMManager.share userImConnectWithUid:[NSString stringWithFormat:@"%@", self.infoModel.uid] withName:self.infoModel.name withPhoto:self.infoModel.photourl];
        !complete ?: complete();
    }];
}


// 获取用户信息 code == 404007 信息未完成
- (void)loadUserInfoData:(XYLoginclient)loginClient block:(void(^)(int))block withConnect:(BOOL)isConnect
{
    NSString *API = @"";
    if (loginClient == XYC) {
        API = XY_LoadUserInfoData;
    } else {
        API = XY_B_getuserrecruiter;
    }
    NSDictionary *params = @{};
    [[NetworkManager instance] sendReq:params pageUrl:API urlVersion:nil endLoad:NO viewController:nil complete:^(id result, int successCode, NSString *errowMessage) {
        NSLog(@"%@", result);
        if (successCode == 0) {
            NSDictionary *dict = [result[@"data"] firstObject];
            UserInfoModel *model = [UserInfoModel yy_modelWithJSON:dict];
            self.infoModel = model;
            if (loginClient == XYC) {
                self.tempCInfo = model;
            } else {
                self.tempBInfo = model;
            }
            RCUserInfo *info = [[RCUserInfo alloc]initWithUserId:model.rongid name:model.name portrait:model.photourl];
            [[RCIM sharedRCIM] refreshUserInfoCache:info withUserId:model.rongid];
        }
        else
        {
            if (loginClient == XYC) {
                self.infoModel.name = self.tempBInfo.name;
                self.infoModel.mobile = self.tempBInfo.mobile;
                self.infoModel.sex = self.tempBInfo.sex;
                self.infoModel.photourl = self.tempBInfo.photourl;
                self.infoModel.wechat = self.tempBInfo.wechat;
            } else {
                self.infoModel.name = self.tempCInfo.name;
                self.infoModel.mobile = self.tempCInfo.mobile;
                self.infoModel.sex = self.tempCInfo.sex;
                self.infoModel.photourl = self.tempCInfo.photourl;
                self.infoModel.wechat = self.tempCInfo.wechat;
            }
            [ToastView presentToastWithin:[UIApplication sharedApplication].keyWindow withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
        !block ?: block(successCode);
    } errorBlock:^(id error) {
        !block ?: block(-1);
    }];
}


- (CityModel *)getCityValue
{
    CityModel *selectCityModel = [[CityModel alloc]init];
    if (self.cityName.length > 0) {
        if (self.provinceList.count == 0) {
            [self resolutionWithLocalCity];
        }
        for (ProvinceModel *proModel in self.provinceList) {
            NSArray *array = proModel.cityList;
            for (CityModel *cityModel in array) {
                if ([cityModel.shortname isEqualToString:self.cityName]) {
                    selectCityModel = cityModel;
                }
            }
        }

        
        if (selectCityModel.name.length == 0) {
            selectCityModel.code = @"310100";
            selectCityModel.name = @"上海市";
            selectCityModel.shortname = @"上海";
        }
    }
    else
    {
        selectCityModel.code = @"310100";
        selectCityModel.name = @"上海市";
        selectCityModel.shortname = @"上海";
    }
    
    self.currentCityModel = selectCityModel;
    self.currentPartJobCityModel = selectCityModel;
    self.currentFullJobCityModel = selectCityModel;
    return selectCityModel;
}







- (void)getLoginOut
{
    NSDictionary *params = @{};
    [[NetworkManager instance] sendReq:params pageUrl:@"loginout" urlVersion:nil endLoad:NO viewController:nil complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            [UserManager share].infoModel = nil;
            [UserManager share].token = @"";
            [UserManager share].rongtoken = @"";
            [UserManager share].loginclient = @"";
            [UserManager share].currentFullJobCityModel = nil;
            [UserManager share].currentPartJobCityModel = nil;
//            [UIApplication sharedApplication].keyWindow = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
        }
        else
        {
            [ToastView presentToastWithin:[UIApplication sharedApplication].keyWindow withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}



- (void)configureWithLocationWithBlock:(ReturnCityBlock)block
{
    
    self.locationManager = [[AMapLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager setDesiredAccuracy:(kCLLocationAccuracyHundredMeters)];
    self.locationManager.locationTimeout = 60;
    self.locationManager.reGeocodeTimeout = 60;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        NSString *city;
        if ([regeocode.city containsString:@"市"]) {
            city = [regeocode.city substringWithRange:(NSMakeRange(0, regeocode.city.length - 1))];
        }
        [UserManager share].cityName = city;
        [[UserManager share] getCityValue];
        [UserManager share].longitude = location.coordinate.longitude;
        [UserManager share].latitude = location.coordinate.latitude;
        block();
    }];
}
- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager*)locationManager
{
    [locationManager requestLocation];
}


- (void)judgeLocationWithBlock:(ReturnLocationBlock)block
{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
        block(YES);
        //定位功能可用
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        block(NO);
    };
}

- (void)shareToWX:(NSString *)jobType jobId:(NSString *)jobId {
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        [NetworkManager sendReq:@{@"jobtype": jobType, @"jobid":jobId} pageUrl:XY_share complete:^(id result) {
            NSArray *arr = result[@"data"];
            if (arr.count > 0) {
                NSDictionary *dict = arr.firstObject;
                NSURL *pic = [NSURL URLWithString:dict[@"picture"]];
                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:pic completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                    FYShareViewController *vc = [[FYShareViewController alloc]init:dict[@"url"] title:dict[@"title"] des:dict[@"content"] img:image];
                    [[UIViewController visibleViewController] presentViewController:vc animated:YES completion:nil];
                }];
            }
            
        }];
    } else {
        [ToastView show:@"该设备未安装微信"];
    }
}

- (void)clearMobileCacheWithViewController:(UIViewController *)viewController withBlock:(ReturnCityBlock)block
{
    CGFloat folderSize =[[SDImageCache sharedImageCache] totalDiskSize]/1024.0/1024.0;
    //   NSLog(@"%f",folderSize);
    NSString * alertStr = [NSString stringWithFormat:@"缓存大小为%.1fM.确定要清理缓存吗?",folderSize];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:alertStr message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^
         {
             block();
         }];
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [viewController presentViewController:alertVC animated:YES completion:nil];
    
    //            LabelOfLabelCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [self createAlertForVersion:@"清空缓存" messageStr:alertStr isSee:YES stringArray:@[@"取消",@"确定"] currentVC:self sureBlock:^{
//        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^
//         {
//             [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
//         }];
//    } cancelBlock:^{
//
//    }];
}

- (void)requestAuth:(FaceAction)faceAction complete:(void(^)(void))complete {
    [NetworkManager sendReq:nil pageUrl:XY_B_aliyunface complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count >0 ) {
            NSDictionary *dict = arr.firstObject;
            NSString *token = [NSString stringWithFormat:@"%@", dict[@"token"]];
            __block NSString *ticketid = [NSString stringWithFormat:@"%@", dict[@"ticketid"]];
            faceAction(token, ticketid, ^{
                [self requestAuthToken:ticketid complete:complete];
            });
        }
    }];
}

- (void)requestAuthToken:(NSString *)ticketid  complete:(void(^)(void))complete  {
    NSDictionary *params = @{@"ticketid":ticketid};
    [NetworkManager sendReq:params pageUrl:XY_B_aliyunfacestatus complete:^(id result) {
        complete();
    }];
}

+(void)start:(NSString *)verifyToken rpCompleted:(void (^)(AUDIT))rpCompleted withVC:(UINavigationController *)nav {
#if TARGET_IPHONE_SIMULATOR
    
#else
    [RPSDK start:verifyToken rpCompleted:rpCompleted withVC:nav];
#endif
}

@end
