//
//  BRBranchStoreNameViewController.h
//  XianYu
//
//  Created by Yan on 2019/9/23.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRBranchStoreNameViewController : UIViewController

@property (copy, nonatomic) NSString *storeNm;

@property (copy, nonatomic) NSString *branchStoreNm;

@property (nonatomic, copy) void(^complete)(NSString *name);
@end

NS_ASSUME_NONNULL_END
