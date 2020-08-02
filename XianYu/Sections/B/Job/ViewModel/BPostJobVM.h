//
//  BPostJobVM.h
//  XianYu
//
//  Created by Yan on 2019/7/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTCellModel.h"
#import "BBenefitModel.h"
#import "BJobModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPostJobVM : NSObject

@property (assign, nonatomic) NSInteger type;

@property (nonatomic, strong) NSArray<NSArray<LTCellModel*>*> *dataSource;

@property (nonatomic, strong) LTCellModel *postion;

@property (nonatomic, strong) LTCellModel *postionNm;

@property (nonatomic, strong) LTCellModel *pay;

@property (nonatomic, strong) LTCellModel *age;

@property (nonatomic, strong) LTCellModel *degree;

@property (nonatomic, strong) LTCellModel *exp;

@property (nonatomic, strong) LTCellModel *benefit;

@property (nonatomic, strong) LTCellModel *address;

@property (nonatomic, strong) LTCellModel *workDate;

@property (nonatomic, strong) LTCellModel *store;

@property (nonatomic, strong) LTCellModel *tel;

@property (nonatomic, strong) LTCellModel *des;

@property (nonatomic, strong) BJobModel *jobModel;

- (NSString *)transEdu:(NSString *)edu;

- (void)requestSaveJob:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
