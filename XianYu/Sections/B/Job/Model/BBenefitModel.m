//
//  BBenefitModel.m
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BBenefitModel.h"

@implementation BBenefitModel
- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}
@end
