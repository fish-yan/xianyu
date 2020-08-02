//
//  BJStoreListViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMStoreManagerVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface BJStoreListViewController : UIViewController
@property (copy, nonatomic) void(^complete)(BMStoreManagerModel *model);
@end

NS_ASSUME_NONNULL_END
