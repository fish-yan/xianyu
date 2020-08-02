//
//  C_Mine_Resume_JobExpModel.h
//  XianYu
//
//  Created by lmh on 2019/7/14.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_Mine_Resume_JobExpModel : BaseModel

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, copy) NSString *startend;

@property (nonatomic, copy) NSString *jobType;

@property (nonatomic, copy) NSString *jobname;

@property (nonatomic, copy) NSString *shopname;

@end

NS_ASSUME_NONNULL_END
