//
//  XYDobuleASViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYDobuleASViewController : UIViewController

@property (nonatomic, copy) NSNumber *first;

@property (nonatomic, copy) NSNumber *second;

@property (nonatomic, copy) NSString *headTitle;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *selectUnit;

+(XYDobuleASViewController *)show:(NSArray<NSNumber *> *)firstArr secArr:(NSArray<NSNumber *> *)secArr complete:(void(^)(NSNumber *first, NSNumber *second))complete;
@end

NS_ASSUME_NONNULL_END
