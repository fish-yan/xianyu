//
//  BMStoreManagerVM.h
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMStoreManagerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMStoreManagerVM : NSObject

@property (assign, nonatomic) NSInteger total;

@property (assign, nonatomic) NSInteger pageNum;

@property (strong, nonatomic) NSMutableArray<BMStoreManagerModel *> *dataSource;

- (void)requestStoreList:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
