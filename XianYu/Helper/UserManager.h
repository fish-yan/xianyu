//
//  UserManager.h
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"
#import "UserInfoModel.h"
#import "ProvinceModel.h"
#import "JobTypeModel.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "DefineEnum.h"
#import <RPSDK/RPSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReturnBlock)(id result);

typedef void(^ReturnCityBlock)(void);

typedef void(^ReturnLocationBlock)(BOOL result);

typedef void(^FaceCallBack)(void);

typedef void(^FaceAction)(NSString *token, NSString *ticketid, FaceCallBack faceCallBack);

@interface UserManager : BaseModel <AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;




+ (UserManager *)share;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *loginclient;

@property (nonatomic, strong) NSMutableArray<ProvinceModel *> *provinceList;

@property (nonatomic, strong) NSMutableArray<JobTypeModel *> *jobList;

@property (nonatomic, strong) NSMutableArray<JobDetailModel *> *partJobList;

@property (nonatomic, strong) UserInfoModel *infoModel;

@property (nonatomic, strong) UserInfoModel *tempBInfo;

@property (nonatomic, strong) UserInfoModel *tempCInfo;

@property (nonatomic, assign) ReturnBlock myBlock;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, strong) CityModel *currentCityModel;

@property (nonatomic, strong) CityModel *currentFullJobCityModel;

@property (nonatomic, strong) CityModel *currentPartJobCityModel;


@property (nonatomic, assign) double latitude;

@property (nonatomic, assign) double longitude;

- (void)loadProvice;

- (void)loadJobList;

- (void)loadPartJobList;

- (CityModel *)getCityValue;

- (NSDictionary *)loadLocalCityAllData;

- (void)configureWithLocationWithBlock:(ReturnCityBlock)block;

- (void)getLoginOut;


- (void)judgeLocationWithBlock:(ReturnLocationBlock)block;

- (void)switchClient:(XYLoginclient)client complete:(void(^_Nullable)(void) )complete;
- (void)loadUserInfoData:(XYLoginclient)loginClient block:(void(^)(int))block withConnect:(BOOL)isConnect;

- (void)shareToWX:(NSString *)jobType jobId:(NSString *)jobId;

//清除f缓存
- (void)clearMobileCacheWithViewController:(UIViewController *)viewController withBlock:(ReturnCityBlock)block;

/// 个人认证
- (void)requestAuth:(FaceAction)faceAction complete:(void(^)(void))complete;

+(void)start:(NSString *)verifyToken rpCompleted:(void (^)(AUDIT))rpCompleted withVC:(UINavigationController *)nav;

@end

NS_ASSUME_NONNULL_END
