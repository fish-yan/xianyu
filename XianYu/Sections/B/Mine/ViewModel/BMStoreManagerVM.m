//
//  BMStoreManagerVM.m
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BMStoreManagerVM.h"

@implementation BMStoreManagerVM

- (NSMutableArray<BMStoreManagerModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return (NSMutableArray<BMStoreManagerModel *> *)_dataSource;
}

- (void)requestStoreList:(void(^)(BOOL success))complete {
    NSDictionary *dict = @{@"pageNum":[NSString stringWithFormat:@"%ld", self.pageNum], @"pageSize":@"20"};
    
    [NetworkManager sendReq:dict pageUrl:XY_B_shoplist isLoading:NO complete:^(id result) {
        NSArray *arr = result[@"data"];
        self.total = [result[@"total"] integerValue];
        if (self.pageNum == 1) {
            self.dataSource = [NSMutableArray array];
        }
        for (NSDictionary *dict in arr) {
            BMStoreManagerModel *model = [[BMStoreManagerModel alloc]init];
            [model yy_modelSetWithJSON:dict];
            [self.dataSource addObject:model];
        }
        complete(YES);
    } failure:^(NSInteger code, NSString *msg) {
        complete(NO);
    }];
}

@end
