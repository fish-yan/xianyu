//
//  BRPositionDetailViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRPositionDetailViewController : UIViewController
@property (copy, nonatomic) NSString *name;
@property (nonatomic, copy) void(^complete)(NSString *name);
@end

NS_ASSUME_NONNULL_END
