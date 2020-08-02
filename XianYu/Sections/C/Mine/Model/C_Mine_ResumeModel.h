//
//  C_Mine_ResumeModel.h
//  XianYu
//
//  Created by lmh on 2019/7/14.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_Mine_ResumeModel : BaseModel


@property (nonatomic, strong) NSNumber *ID;

@property(nonatomic, assign) NSInteger jobtype;

@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *wechat;

@property(nonatomic, assign) NSInteger age;

@property(nonatomic, assign) NSInteger education;

@property (nonatomic, copy) NSString *educationname;
@property (nonatomic, copy) NSString *jobexp;
@property(nonatomic, assign) NSInteger jobstatus;
@property(nonatomic, assign) NSInteger jobintention;
@property (nonatomic, copy) NSString *jobaddress;

@property (nonatomic, strong) NSArray *wantjob;
@property (nonatomic, copy) NSString *provincecode;
@property (nonatomic, copy) NSString *citycode;
@property (nonatomic, copy) NSString *exparrtime;
@property (nonatomic, copy) NSString *selfdes;
@property (copy, nonatomic) NSString *pandc;
@property (nonatomic, strong) NSMutableArray *jexps;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *provincename;

@property (nonatomic, copy) NSString *cityname;

@property (nonatomic, copy) NSString *exparrtimestring;



@property (nonatomic, copy) NSString *jobphotoone;
@property (nonatomic, copy) NSString *jobphototwo;
@property (nonatomic, copy) NSString *jobphotothree;






@end

NS_ASSUME_NONNULL_END
