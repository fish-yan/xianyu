//
//  BRLicenseResultViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRLicenseResultViewController : UIViewController

/// 0：认证拒绝 1：认证通过
@property (nonatomic, assign) NSInteger type;

@property (copy, nonatomic) void(^complete)(BOOL isMsg);

@end

NS_ASSUME_NONNULL_END
