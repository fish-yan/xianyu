//
//  BRTradeSelectorViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRTradeSelectorVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRTradeSelectorViewController : UIViewController

@property (nonatomic, strong) BRTradeModel *selectModel;

@property (nonatomic, copy) void(^complete)(BRTradeModel *model);

@end

NS_ASSUME_NONNULL_END
