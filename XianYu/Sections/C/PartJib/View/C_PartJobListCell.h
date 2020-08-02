//
//  C_PartJobListCell.h
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_PartJobListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_PartJobListCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, strong) UILabel *rangeLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIImageView *logoIamgeView;

@property (nonatomic, strong) UILabel *companyLabel;

@property (nonatomic, strong) UIButton *contractButton;

@property (nonatomic, strong) UIView *lineView;

- (void)configureWithModel:(C_PartJobListModel *)model;

@end

NS_ASSUME_NONNULL_END
