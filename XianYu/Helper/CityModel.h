//
//  CityModel.h
//  XianYu
//
//  Created by lmh on 2019/7/12.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"
#import "AreaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityModel : BaseModel

@property (nonatomic, copy) NSString *code;

@property(nonatomic, assign) NSInteger level;

@property(nonatomic, strong) NSMutableArray<AreaModel *> *areaList;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *shortname;

@end

NS_ASSUME_NONNULL_END