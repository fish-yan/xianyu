//
//  C_JobInfoViewController.h
//  XianYu
//
//  Created by lmh on 2019/6/27.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_JobInfoViewController : BaseViewController

@property (nonatomic, strong) NSNumber *jobId;

@property (nonatomic, strong) CityModel *cityModel;

@end

NS_ASSUME_NONNULL_END
