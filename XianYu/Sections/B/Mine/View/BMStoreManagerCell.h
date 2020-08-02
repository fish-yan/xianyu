//
//  BMStoreManagerCell.h
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMStoreManagerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMStoreManagerCell : UITableViewCell

@property (nonatomic, strong) BMStoreManagerModel *model;

@property (copy, nonatomic) void(^btnAction)(UIButton *btn);
@end

NS_ASSUME_NONNULL_END
