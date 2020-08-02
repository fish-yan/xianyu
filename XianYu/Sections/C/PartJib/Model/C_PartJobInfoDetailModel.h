//
//  C_PartJobInfoDetailModel.h
//  XianYu
//
//  Created by lmh on 2019/7/27.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_PartJobInfoDetailModel : BaseModel

@property (nonatomic, strong) NSNumber *id;

@property(nonatomic, assign) NSInteger jobtype;

@property (nonatomic, copy) NSString *jobname;

@property (nonatomic, copy) NSString *classname;

@property(nonatomic, assign) NSInteger wagetype;

@property (nonatomic, copy) NSString *wagedes;

@property (nonatomic, copy) NSString *age;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *educationname;

@property (nonatomic, copy) NSString *jobexp;

@property (nonatomic, strong) NSArray *welfare;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *timeslot;

@property (nonatomic, strong) NSNumber *shopid;

@property (nonatomic, copy) NSString *shopname;
@property (nonatomic, copy) NSString *provincecode;

@property (nonatomic, copy) NSString *citycode;

@property (nonatomic, copy) NSString *towncode;

@property (nonatomic, copy) NSString *streetcode;

@property (nonatomic, copy) NSString *lon;

@property (nonatomic, copy) NSString *lad;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *juli;

@property (nonatomic, copy) NSString *jobdesc;

@property(nonatomic, assign) NSInteger classid;

@property(nonatomic, assign) NSInteger deliverystatus;

@property (nonatomic, copy) NSString *rephoto;

@property (nonatomic, copy) NSString *rename;

@property (nonatomic, copy) NSString *reposition;


@end

NS_ASSUME_NONNULL_END
