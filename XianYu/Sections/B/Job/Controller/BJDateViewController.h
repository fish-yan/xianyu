//
//  BJDateViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BJDateViewController : UIViewController
@property (copy, nonatomic) NSString *date1Str;
@property (copy, nonatomic) NSString *date2Str;
@property (copy, nonatomic) NSString *time1Str;
@property (copy, nonatomic) NSString *time2Str;
@property (copy, nonatomic) void(^complete)(NSString *date1, NSString *date2, NSString *time1, NSString *time2);
@end

NS_ASSUME_NONNULL_END
