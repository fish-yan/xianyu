//
//  BRStoreNameViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRTFViewController : UIViewController

@property(assign, nonatomic) UIKeyboardType keyboardType;

@property (assign, nonatomic) NSInteger maxLen;

+ (BRTFViewController *)start:(NSString *)title detail:(NSString *)detail des:(NSString *)des placeholder:(NSString *)placeholder complete:(void(^)(NSString *text))complete;

@end

NS_ASSUME_NONNULL_END
