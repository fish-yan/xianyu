//
//  BRTradeSelectorVM.m
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRTradeSelectorVM.h"

@implementation BRTradeSelectorVM

- (void)requestTrade:(void(^)(BOOL success))complete {
    [NetworkManager sendReq:nil pageUrl:XY_B_getindustrys complete:^(id result) {
        NSArray *arr = result[@"data"];
        self.dataSource = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            BRTradeModel *model = [[BRTradeModel alloc]init];
            [model yy_modelSetWithJSON:dict];
            [self.dataSource addObject:model];
        }
        complete(YES);
    }];
}

@end
