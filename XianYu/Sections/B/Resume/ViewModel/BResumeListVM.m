//
//  BResumeListVM.m
//  XianYu
//
//  Created by Yan on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BResumeListVM.h"

@implementation BResumeListVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shopsee = @"3";
    }
    return self;
}

- (NSMutableArray<BResumeModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)requestResumeList:(void(^)(BOOL success))complete {
    NSDictionary *params = @{@"shopsee":self.shopsee, @"pageNum": [NSString stringWithFormat:@"%ld", self.pageNum], @"pageSize":@"20"};
    [NetworkManager sendReq:params pageUrl:XY_B_getmyshopresume isLoading:NO complete:^(id result) {
        NSArray *arr = result[@"data"];
        self.total = [result[@"total"] integerValue];
        self.dataSource = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            BResumeModel *model = [BResumeModel yy_modelWithJSON:dict];
            [self.dataSource addObject:model];
        }
        complete(YES);
    } failure:^(NSInteger code, NSString *msg) {
        complete(NO);
    }];
}


@end
