//
//  BResumeJobExpModel.h
//  XianYu
//
//  Created by Yan on 2019/7/25.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BResumeJobExpModel : BaseModel
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *startend;
@property (copy, nonatomic) NSString *startdate;
@property (copy, nonatomic) NSString *enddate;
@property (copy, nonatomic) NSString *jobType;
@property (copy, nonatomic) NSString *jobposition;
@property (copy, nonatomic) NSString *jobname;
@property (copy, nonatomic) NSString *shopname;
@property (copy, nonatomic) NSString *jobdescribe;
@property (copy, nonatomic) NSString *provincecode;
@property (copy, nonatomic) NSString *provincename;
@property (copy, nonatomic) NSString *cityname;
@property (copy, nonatomic) NSString *citycode;

@end

NS_ASSUME_NONNULL_END
