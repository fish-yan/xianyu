//
//  BRAddressSelectorVM.m
//  XianYu
//
//  Created by Yan on 2019/7/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRAddressSelectorVM.h"

@implementation BRAddressSelectorVM

- (NSMutableArray<BRAddressModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)requestAddressList:(void(^)(BOOL success))complete {
    NSDictionary *params = @{@"pageNum":[NSString stringWithFormat:@"%ld", self.pageNum], @"pageSize":@"20"};
    [NetworkManager sendReq:params pageUrl:XY_B_getaddress isLoading:NO complete:^(id result) {
        if (self.pageNum == 1) {
            self.dataSource = [NSMutableArray array];
        }
        self.total = [result[@"total"] integerValue];
        NSArray *arr = result[@"data"];
        for (NSDictionary *dict in arr) {
            BRAddressModel *model = [[BRAddressModel alloc]init];
            [model yy_modelSetWithJSON:dict];
            [self.dataSource addObject:model];
        }
        complete(YES);
    } failure:^(NSInteger code, NSString *msg) {
        complete(NO);
    }];
}

@end
