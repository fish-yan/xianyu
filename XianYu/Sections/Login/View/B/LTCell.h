//
//  LTCell.h
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTCellModel.h"


#define LTCELL @"LTCell"

NS_ASSUME_NONNULL_BEGIN

@interface LTCell : UITableViewCell

@property (nonatomic, strong) LTCellModel *model;

@end

NS_ASSUME_NONNULL_END
