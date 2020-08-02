//
//  CMWantJobViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/26.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMWantJobVM.h"
NS_ASSUME_NONNULL_BEGIN

@interface CMWantJobViewController : UIViewController
@property (strong, nonatomic) CMWantJobVM *viewModel;
@property (copy, nonatomic) void(^complete)(BResumeModel *model);
@end

NS_ASSUME_NONNULL_END
