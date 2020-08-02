//
//  BBenefitVM.m
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BBenefitVM.h"

@implementation BBenefitVM

- (NSMutableArray<BBenefitModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)subSource {
    if (!_subSource) {
        _subSource = [NSMutableArray array];
    }
    return _subSource;
}

- (void)requestBenefit:(void(^)(BOOL success))complete {
    [NetworkManager sendReq:nil pageUrl:XY_B_getwelfares complete:^(id result) {
        NSArray *arr = result[@"data"];
        for (NSDictionary *dict in arr) {
            BBenefitModel *typeModel = [BBenefitModel yy_modelWithJSON:dict];
            for (NSDictionary *sub in dict[@"sub"]) {
                [typeModel.list addObject:sub[@"value"]];
            }
            [self.dataSource addObject:typeModel];
        }
        complete(YES);
    }];
}


@end
