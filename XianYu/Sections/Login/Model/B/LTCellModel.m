//
//  LTCellModel.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "LTCellModel.h"

@implementation LTCellModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"";
        self.des = @"";
        self.placeholder = @"";
        self.type = LTNormal;
    }
    return self;
}


+ (instancetype)initWith:(NSString *)title des:(NSString *)des placeholder:(NSString *)placeholder type:(LTCellType)type {
    LTCellModel *model = [[LTCellModel alloc] init];
    model.title = title;
    model.des = des;
    model.placeholder = placeholder;
    model.type = type;
    return model;
}

@end
