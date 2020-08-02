//
//  CityModel.m
//  XianYu
//
//  Created by lmh on 2019/7/12.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel

- (NSMutableArray<StreetModel *> *)streetList {
    if (!_streetList) {
        _streetList = [NSMutableArray array];
    }
    return _streetList;
}

@end
