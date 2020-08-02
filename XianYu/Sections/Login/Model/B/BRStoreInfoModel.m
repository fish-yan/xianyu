//
//  BRStoreInfoModel.m
//  XianYu
//
//  Created by Yan on 2019/7/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRStoreInfoModel.h"

@implementation BRStoreInfoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.id = @"";
        self.position = @"";
        self.shopname = @"";
        self.idenname = @"";
        self.addressid = @"";
        self.industryid = @"";
        self.scale = @"";
        self.company = @"";
        self.introduction = @"";
        self.auditstatus = @"";
    }
    return self;
}

@end
