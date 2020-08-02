//
//  JobTypeModel.m
//  XianYu
//
//  Created by lmh on 2019/7/12.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "JobTypeModel.h"

@implementation JobTypeModel

- (NSMutableArray<JobDetailModel *> *)detailList {
    if (!_detailList) {
        _detailList = [NSMutableArray array];
    }
    return _detailList;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.id = [value integerValue];
    }
}

@end
