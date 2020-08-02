//
//  BRTradeSelectorVM.h
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRTradeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRTradeSelectorVM : NSObject

@property (strong, nonatomic) NSMutableArray<BRTradeModel *> *dataSource;

- (void)requestTrade:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
