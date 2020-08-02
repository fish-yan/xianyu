//
//  BMMoreServiceMode.m
//  XianYu
//
//  Created by Yan on 2019/8/2.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BMMoreServiceMode.h"

@implementation BMMoreServiceMode
- (NSMutableArray<NSDictionary *> *)company {
    if (!_company) {
        _company = [NSMutableArray array];
    }
    return _company;
}
@end
