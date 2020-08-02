//
//  BJobListVM.h
//  XianYu
//
//  Created by Yan on 2019/7/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJobModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BJobListVM : NSObject

@property (assign, nonatomic) NSInteger total;

@property (strong, nonatomic) NSMutableArray<BJobModel*> *dataSource;

@property (assign, nonatomic) NSInteger pageNum;

- (void)requestJobList:(void(^)(BOOL success))complete;

+ (void)requestChangeStatus:(NSString *)jobId type:(NSString *)type status:(NSString *)status complete:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
