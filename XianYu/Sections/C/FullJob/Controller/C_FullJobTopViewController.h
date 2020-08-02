//
//  C_FullJobTopViewController.h
//  XianYu
//
//  Created by lmh on 2019/7/27.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_FullJobTopViewController : BaseViewController

@property (nonatomic, assign) BOOL isFullJob;

@property (nonatomic, strong) RACSubject *mySubject;

@end

NS_ASSUME_NONNULL_END
