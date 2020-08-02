//
//  XYActionSheetViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYActionSheetViewController : UIViewController

@property (nonatomic, copy) NSString *selectTitle;

@property (nonatomic, copy) NSString *headTitle;

+(XYActionSheetViewController *)show:(NSArray<NSString *> *)array complete:(void(^)(NSString *title))complete;

@end

NS_ASSUME_NONNULL_END
