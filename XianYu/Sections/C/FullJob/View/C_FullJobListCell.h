//
//  C_FullJobListCell.h
//  XianYu
//
//  Created by lmh on 2019/6/24.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_FullJobListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_FullJobListCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *companyLabe;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UIButton *clickButton;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *bottomView;

- (void)configureWithModel:(C_FullJobListModel *)model;

@end

NS_ASSUME_NONNULL_END
