//
//  BJobDetailViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BJobDetailViewController : UIViewController
@property (nonatomic, assign) NSInteger type; // 0 全职 1兼职
@property (nonatomic, copy) NSString *jobId;
@end

NS_ASSUME_NONNULL_END
