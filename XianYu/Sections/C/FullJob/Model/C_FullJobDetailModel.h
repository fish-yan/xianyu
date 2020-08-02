//
//  C_FullJobDetailModel.h
//  XianYu
//
//  Created by lmh on 2019/7/22.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_FullJobDetailModel : BaseModel

@property (nonatomic, copy) NSString *jobname;
@property (nonatomic, copy) NSString *classname;

@property(nonatomic, assign) NSInteger jobtype;

@property (nonatomic, copy) NSString *wagedes;


@property (nonatomic, copy) NSString *age;


@property (nonatomic, copy) NSString *sex;

@property (nonatomic, strong) NSArray *welfare;

@property (nonatomic, copy) NSString *educationname;


@property (nonatomic, copy) NSString *jobexp;


@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, copy) NSString *industry;
@property (nonatomic, copy) NSString *scale;
@property (nonatomic, copy) NSString *shoplogo;
@property (nonatomic, copy) NSString *environmentimgs;

@property (nonatomic, copy) NSString *juli;


@property (nonatomic, copy) NSString *address;


@property (nonatomic, copy) NSString *lon;

@property (nonatomic, copy) NSString *lad;


@property (nonatomic, copy) NSString *jobdesc;


@property (nonatomic, copy) NSString *anquan;

//private Byte  deliverystatus;//0 可投 1不可投
@property (nonatomic, assign) int deliverystatus;

@property (nonatomic, strong) NSNumber *classid;

@property (nonatomic, copy) NSString *rephoto;

@property (nonatomic, copy) NSString *rename;

@property (nonatomic, copy) NSString *reposition;

@property(nonatomic, assign) int iscan;

@end

NS_ASSUME_NONNULL_END
