//
//  BJobListModel.m
//  XianYu
//
//  Created by Yan on 2019/7/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BJobModel.h"

@implementation BJobModel
- (NSMutableArray *)welfare {
    if (!_welfare) {
        _welfare = [NSMutableArray array];
    }
    return _welfare;
}
@end
