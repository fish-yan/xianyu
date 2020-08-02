//
//  BRAddressSelectorVM.h
//  XianYu
//
//  Created by Yan on 2019/7/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRAddressSelectorVM : NSObject

@property (assign, nonatomic) NSInteger total;

@property (strong, nonatomic) NSMutableArray<BRAddressModel *> *dataSource;

@property (assign, nonatomic) NSInteger pageNum;

- (void)requestAddressList:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
