//
//  BRAddressDetailVM.h
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTCellModel.h"
#import "BRAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRAddressDetailVM : NSObject

@property (nonatomic, strong) NSArray<LTCellModel*> *dataSource;

@property (nonatomic, strong) LTCellModel *add;

@property (nonatomic, strong) LTCellModel *addDetail;

@property (nonatomic, strong) BRAddressModel *model;

- (void)requestAddAddress:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
