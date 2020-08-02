//
//  BJobListVM.m
//  XianYu
//
//  Created by Yan on 2019/7/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BJobListVM.h"

@implementation BJobListVM

- (NSMutableArray<BJobModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)requestJobList:(void(^)(BOOL success))complete {
    NSDictionary *params = @{@"pageNum":[NSString stringWithFormat:@"%ld", self.pageNum], @"pageSize":@"20"};
    [NetworkManager sendReq:params pageUrl:XY_B_getmyreleasejob isLoading:NO  complete:^(id result) {
        if (self.pageNum == 1) {
            self.dataSource = [NSMutableArray array];
        }
        self.total = [result[@"total"] integerValue];
        NSArray *arr = result[@"data"];
        for (NSDictionary *dict in arr) {
            BJobModel *model = [BJobModel yy_modelWithJSON:dict];
            [self.dataSource addObject:model];
        }
        complete(YES);
    } failure:^(NSInteger code, NSString *msg) {
        complete(NO);
    }];
}

+ (void)requestChangeStatus:(NSString *)jobId type:(NSString *)type status:(NSString *)status complete:(void(^)(BOOL success))complete {
    NSDictionary *params = @{@"id":jobId, @"type":type, @"status":status};
    [NetworkManager sendReq:params pageUrl:XY_B_updatejobstatus complete:^(id result) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notification_reload_job_list object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:notification_reload_job_detail object:nil];
        complete(YES);
    }];
}



@end
