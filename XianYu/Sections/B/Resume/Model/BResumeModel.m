//
//  BResumeModel.m
//  XianYu
//
//  Created by Yan on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BResumeModel.h"

@implementation BResumeModel
- (NSMutableArray<BResumeJobExpModel *> *)jobExps {
    if (!_jobExps) {
        _jobExps = [NSMutableArray array];
    }
    return _jobExps;
}
@end
