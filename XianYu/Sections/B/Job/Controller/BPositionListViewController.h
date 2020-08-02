//
//  BPositionListViewController.h
//  XianYu
//
//  Created by Yan on 2019/7/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPositionListViewController : UIViewController
@property (nonatomic, strong) JobTypeModel *typeModel;
@property (nonatomic, strong) JobDetailModel *detailModel;
@property (assign, nonatomic) NSInteger type;
@property (copy, nonatomic) void(^complete)(JobDetailModel *model);
@end

NS_ASSUME_NONNULL_END
