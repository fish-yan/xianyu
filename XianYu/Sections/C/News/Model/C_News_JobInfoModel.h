//
//  C_News_JobInfoModel.h
//  XianYu
//
//  Created by lmh on 2019/7/30.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_News_JobInfoModel : BaseModel

@property(nonatomic, assign) NSInteger jobtype;

@property (nonatomic, strong) NSNumber *id;

@property (nonatomic, copy) NSString *classname;

@property (nonatomic, copy) NSString *wagedes;

@property (nonatomic, strong) NSArray *welfare;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, copy) NSString *juli;

@property(nonatomic, assign) NSInteger wagetype;

@property (nonatomic, copy) NSString *wagename;

@end

NS_ASSUME_NONNULL_END
