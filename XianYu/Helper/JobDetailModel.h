//
//  JobDetailModel.h
//  XianYu
//
//  Created by Yan on 2019/7/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobDetailModel : BaseModel

@property(nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *level;

@end

NS_ASSUME_NONNULL_END
