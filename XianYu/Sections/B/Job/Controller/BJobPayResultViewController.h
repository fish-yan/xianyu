//
//  BJobPayResultViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/25.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BJobPayResultViewController : UIViewController

@property (copy, nonatomic) NSString *stauts;
@property (copy, nonatomic) NSString *znum; // 可认证次数
@property (copy, nonatomic) NSString *snum; // 剩余次数
@end

NS_ASSUME_NONNULL_END
