//
//  BBenefitViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBenefitViewController : UIViewController
@property (strong, nonatomic) NSString *selected;
@property (copy, nonatomic) void(^complete)(NSString *selected);
@end

NS_ASSUME_NONNULL_END
