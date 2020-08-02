//
//  UserInfoModel.h
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : BaseModel

@property (nonatomic, assign) BOOL isnew;

@property (nonatomic, assign) BOOL loginclient;


@property (nonatomic, strong) NSNumber *uid;

@property (nonatomic, copy) NSString *photourl;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *brith;


@property (nonatomic, copy) NSString *jobexp;

@property (nonatomic, copy) NSString *rongtoken;

@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *wechat;
@property (copy, nonatomic) NSString *provincecode;
@property (copy, nonatomic) NSString *citycode;
@property (copy, nonatomic) NSString *provincename;
@property (copy, nonatomic) NSString *cityname;
@property (copy, nonatomic) NSString *rongid;
@property (copy, nonatomic) NSString *havepay; // 是否购买会员
@property (copy, nonatomic) NSString *grade; // 会员等级
@property (copy, nonatomic) NSString *servicename; // 会员名称
@property (copy, nonatomic) NSString *label; // 会员标签
@property (copy, nonatomic) NSString *linkupnum; // 沟通数
@property (copy, nonatomic) NSString *normalnum; // 上线数
@property (copy, nonatomic) NSString *releasenum; // 今日发不出数
@property (copy, nonatomic) NSString *deliverynum; // 投递数量
@property (copy, nonatomic) NSString *percentage; // 简历完成度
@end

NS_ASSUME_NONNULL_END
