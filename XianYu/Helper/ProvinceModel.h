//
//  ProvinceMode.h
//  XianYu
//
//  Created by Yan on 2019/7/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProvinceModel : BaseModel

@property (nonatomic, copy) NSString *code;

@property(nonatomic, assign) NSInteger level;

@property(nonatomic, strong) NSMutableArray<CityModel *> *cityList;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *shortname;

@end

NS_ASSUME_NONNULL_END
