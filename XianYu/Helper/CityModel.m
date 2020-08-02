//
//  CityModel.m
//  XianYu
//
//  Created by lmh on 2019/7/12.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (NSMutableArray<AreaModel *> *)areaList {
    if (!_areaList) {
        _areaList = [NSMutableArray array];
    }
    return _areaList;
}

@end
