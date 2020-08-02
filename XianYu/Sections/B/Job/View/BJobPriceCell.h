//
//  BJobPriceCell.h
//  XianYu
//
//  Created by Yan on 2019/7/23.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BJobPriceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BJobPriceCell : UITableViewCell
@property (strong, nonatomic) BJobPriceModel *model;
@property (assign, nonatomic) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
