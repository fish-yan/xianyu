//
//  C_JobInfoListCell.h
//  XianYu
//
//  Created by lmh on 2019/7/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_PartJobListModel.h"
#import "C_PartJobInfoListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_JobInfoListCell : UITableViewCell

@property (nonatomic, strong) UILabel *jobLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *companyLabel;

@property (nonatomic, strong) UILabel *rangeLabel;

@property (nonatomic, strong) UIView *lineView;


- (void)configureWithModel:(C_PartJobListModel *)model;


- (void)configureWithPartJobModel:(C_PartJobInfoListModel *)model;

@end

NS_ASSUME_NONNULL_END
