//
//  CMWantJobVM.h
//  XianYu
//
//  Created by Yan on 2019/7/26.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTCellModel.h"
#import "BResumeJobExpModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMWorkExpVM : NSObject

@property (strong, nonatomic) NSMutableArray<LTCellModel*> *dataSource;

@property (strong, nonatomic) LTCellModel *type;
@property (strong, nonatomic) LTCellModel *position;
@property (strong, nonatomic) LTCellModel *company;
@property (strong, nonatomic) LTCellModel *startDate;
@property (strong, nonatomic) LTCellModel *endDate;
@property (strong, nonatomic) LTCellModel *address;
@property (strong, nonatomic) LTCellModel *des;
@property (strong, nonatomic) BResumeJobExpModel *model;

- (void)requestSaveWorkExp:(void(^)(BOOL success))complete;
- (void)requestDeleteWorkExp:(void(^)(BOOL success))complete;
@end

NS_ASSUME_NONNULL_END
