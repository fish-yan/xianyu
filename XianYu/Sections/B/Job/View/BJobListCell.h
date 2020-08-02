//
//  B_JobManagerListCell.h
//  XianYu
//
//  Created by lmh on 2019/7/9.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BJobModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BJobListCell : UITableViewCell

@property (strong, nonatomic)BJobModel *model;

@property (copy, nonatomic) void(^btnAction)(UIButton *btn);

@end

NS_ASSUME_NONNULL_END
