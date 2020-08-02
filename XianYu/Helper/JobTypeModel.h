//
//  JobTypeModel.h
//  XianYu
//
//  Created by lmh on 2019/7/12.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"
#import "JobDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobTypeModel : BaseModel

@property (nonatomic, strong) NSMutableArray<JobDetailModel *> *detailList;

@property(nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *level;

@end

NS_ASSUME_NONNULL_END
