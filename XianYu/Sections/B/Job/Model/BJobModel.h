//
//  BJobListModel.h
//  XianYu
//
//  Created by Yan on 2019/7/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BJobModel : BaseModel

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *jobname;
@property (copy, nonatomic) NSString *classname;
@property (copy, nonatomic) NSString *jobtype;
@property (copy, nonatomic) NSString *expiredate;
@property (copy, nonatomic) NSString *browsenum;
@property (copy, nonatomic) NSString *deliverynum;
@property (copy, nonatomic) NSString *cationnum;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *updatedate;
@property (copy, nonatomic) NSString *wagetype;
@property (copy, nonatomic) NSString *wagedes;
@property (copy, nonatomic) NSString *classid;
@property (copy, nonatomic) NSString *recruitnum;
@property (copy, nonatomic) NSString *education;
@property (copy, nonatomic) NSString *educationname;
@property (copy, nonatomic) NSString *jobexp;
@property (copy, nonatomic) NSString *welfarenew;
@property (strong, nonatomic) NSMutableArray *welfare;
@property (copy, nonatomic) NSString *provincecode;
@property (copy, nonatomic) NSString *citycode;
@property (copy, nonatomic) NSString *towncode;
@property (copy, nonatomic) NSString *streetcode;
@property (copy, nonatomic) NSString *lon;
@property (copy, nonatomic) NSString *lad;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *shopid;
@property (copy, nonatomic) NSString *shopname;
@property (copy, nonatomic) NSString *age;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *jobdesc;
@property (copy, nonatomic) NSString *juli;
@property (copy, nonatomic) NSString *paystatus;
@property (copy, nonatomic) NSString *startDate;//开始时间
@property (copy, nonatomic) NSString *endDate;//结束时间
@property (copy, nonatomic) NSString *timeslot;//时间段

@end

NS_ASSUME_NONNULL_END
