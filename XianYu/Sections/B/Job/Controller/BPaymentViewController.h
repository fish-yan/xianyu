//
//  BPaymentViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPaymentViewController : UIViewController
@property (copy, nonatomic) NSString *money;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *unit;
@property (copy, nonatomic) void(^complete)(NSString *money, NSString *unit, NSString *type);
@end

NS_ASSUME_NONNULL_END
