//
//  BRStoreInfoVM.h
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTCellModel.h"
#import "BRStoreInfoModel.h"
#import "BRAddressModel.h"
#import "BRTradeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRStoreInfoVM : NSObject

/// 0: 新增，1：修改, 2:查看
@property (assign, nonatomic) NSInteger fromeType;

@property (nonatomic, strong) NSArray *imgs;

@property (nonatomic, strong) NSArray<LTCellModel*> *dataSource;

@property (nonatomic, strong) LTCellModel *photo;

@property (nonatomic, strong) LTCellModel *storeNm;

@property (nonatomic, strong) LTCellModel *branchStoreNm;

@property (nonatomic, strong) LTCellModel *storeAdd;

@property (nonatomic, strong) LTCellModel *employerCount;

@property (nonatomic, strong) LTCellModel *trade;

@property (nonatomic, strong) LTCellModel *storeDes;

@property (nonatomic, strong) LTCellModel *myJob;

@property (nonatomic, strong) LTCellModel *status;

@property (nonatomic, strong) BRStoreInfoModel *storeInfo;

@property (nonatomic, strong) BRAddressModel *addressModel;

@property (nonatomic, strong) BRTradeModel *tradeModel;

- (void)requestSaveStore:(void(^)(BOOL success))complete;

- (void)requestGetStoreInfo:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
