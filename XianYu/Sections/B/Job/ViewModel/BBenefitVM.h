//
//  BBenefitVM.h
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBenefitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBenefitVM : NSObject
@property (strong, nonatomic) NSMutableArray<BBenefitModel*> *dataSource;

@property (strong, nonatomic) NSMutableArray *subSource;

- (void)requestBenefit:(void(^)(BOOL success))complete;
@end

NS_ASSUME_NONNULL_END
