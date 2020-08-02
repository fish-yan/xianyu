//
//  BResumeModel.h
//  XianYu
//
//  Created by Yan on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"
#import "BResumeJobExpModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BResumeModel : BaseModel
@property (copy, nonatomic) NSString *deliveryid;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *jobid;
@property (copy, nonatomic) NSString *jobtype;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *age;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *wechat;
@property (copy, nonatomic) NSString *education;
@property (copy, nonatomic) NSString *educationname;
@property (copy, nonatomic) NSString *exparrtimestring;
@property (copy, nonatomic) NSString *pandc;
@property (copy, nonatomic) NSString *jobexp;
@property (copy, nonatomic) NSString *wantjob;
@property (copy, nonatomic) NSString *shopsee;
@property (copy, nonatomic) NSString *jobstatus;
@property (copy, nonatomic) NSString *jobintention;
@property (copy, nonatomic) NSString *jobaddress;
@property (copy, nonatomic) NSString *photo;
@property (copy, nonatomic) NSString *jobname;
@property (copy, nonatomic) NSString *classname;
@property (copy, nonatomic) NSString *provincecode;
@property (copy, nonatomic) NSString *citycode;
@property (copy, nonatomic) NSString *exparrtime;
@property (copy, nonatomic) NSString *selfdes;
@property (copy, nonatomic) NSString *wantwage;
@property (copy, nonatomic) NSString *dailywage;
@property (copy, nonatomic) NSString *freetime;
@property (copy, nonatomic) NSString *jobphotoone;
@property (copy, nonatomic) NSString *jobphototwo;
@property (copy, nonatomic) NSString *jobphotothree;
@property (strong, nonatomic) NSMutableArray<BResumeJobExpModel *> *jobExps;

@end

NS_ASSUME_NONNULL_END
