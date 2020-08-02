//
//  CMJobTypeViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/27.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMJobTypeViewController : UIViewController
@property (assign, nonatomic) NSInteger type;
@property (strong, nonatomic) NSMutableArray<JobDetailModel *> *selectedArr;
@property (copy, nonatomic) void(^complete)(NSArray<JobDetailModel *> *selectedArr);
@end

NS_ASSUME_NONNULL_END
