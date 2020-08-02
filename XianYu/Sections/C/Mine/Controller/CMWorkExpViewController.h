//
//  CMWantJobViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/26.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMWorkExpVM.h"
#import "BResumeJobExpModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CMWorkExpViewController : UIViewController
@property (strong, nonatomic) CMWorkExpVM *viewModel;
@property (copy, nonatomic) void(^complete)(BResumeJobExpModel * _Nullable model);
@end

NS_ASSUME_NONNULL_END
