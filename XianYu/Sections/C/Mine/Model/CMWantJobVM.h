//
//  CMWantJobVM.h
//  XianYu
//
//  Created by Yan on 2019/7/26.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTCellModel.h"
#import "BResumeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMWantJobVM : NSObject

@property (strong, nonatomic) NSMutableArray<LTCellModel*> *dataSource;

@property (strong, nonatomic) LTCellModel *type;
@property (strong, nonatomic) LTCellModel *address;
@property (strong, nonatomic) LTCellModel *fullMoney;
@property (strong, nonatomic) LTCellModel *position;
@property (strong, nonatomic) LTCellModel *freeTime;
@property (strong, nonatomic) LTCellModel *partMoney;

@property (strong, nonatomic) BResumeModel *model;

- (void)configCells;
@end

NS_ASSUME_NONNULL_END
