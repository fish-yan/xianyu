//
//  BRAddressSelectorViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRAddressSelectorViewController : UIViewController

@property (copy, nonatomic) void(^complete)(BRAddressModel *model);

@end

NS_ASSUME_NONNULL_END
