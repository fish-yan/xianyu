//
//  ProvinceMode.m
//  XianYu
//
//  Created by Yan on 2019/7/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel
- (NSMutableArray<CityModel *> *)cityList {
    if (!_cityList) {
        _cityList = [NSMutableArray array];
    }
    return _cityList;
}
@end
