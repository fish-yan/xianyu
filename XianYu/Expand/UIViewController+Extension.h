//
//  UIViewController+Extension.h
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication(Extension)

@end

@interface UIViewController (Extension)
+ (void)swizzled;

/// 获取当前活动的控制器
+ (UIViewController *)visibleViewController;

@end

NS_ASSUME_NONNULL_END
