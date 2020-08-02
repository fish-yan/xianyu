//
//  BRInfoVM.h
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTCellModel.h"
#import "UserInfoModel.h"
#import "BMStoreManagerModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface BRInfoVM : NSObject

@property (nonatomic, strong) NSArray<NSArray<LTCellModel*>*> *dataSource;

@property (assign, nonatomic) NSInteger type;

@property (nonatomic, strong) LTCellModel *photo;

@property (nonatomic, strong) LTCellModel *name;

@property (nonatomic, strong) LTCellModel *sex;

@property (nonatomic, strong) LTCellModel *job;

@property (nonatomic, strong) LTCellModel *store;

@property (nonatomic, strong) LTCellModel *tel;

@property (nonatomic, strong) LTCellModel *wx;

@property (nonatomic, strong) LTCellModel *home;

@property (nonatomic, strong) UserInfoModel *model;

@property (nonatomic, nonatomic) BMStoreManagerModel *storeManagerModel;

- (void)requestGetMineInfo:(void(^)(BOOL success))complete;

- (void)requestSaveMinInfo:(void(^)(BOOL success))complete;

- (void)requestStoreList:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
