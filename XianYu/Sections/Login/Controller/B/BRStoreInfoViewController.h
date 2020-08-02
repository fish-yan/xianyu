//
//  BRStoreInfoViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRStoreInfoVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRStoreInfoViewController : UIViewController

@property (strong, nonatomic) BRStoreInfoVM *viewModel;

@property (copy, nonatomic) void(^complete)(NSString *storeNm);

@end

NS_ASSUME_NONNULL_END
