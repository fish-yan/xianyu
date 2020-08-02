//
//  BJobDesViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BJobDesViewController : UIViewController
@property (copy, nonatomic) NSString *positionId;
@property (copy, nonatomic) NSString *des;
@property (nonatomic, copy) void(^complete)(NSString *name);
@end

NS_ASSUME_NONNULL_END
