//
//  C_JobLocationCell.h
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_FullJobDetailModel.h"
#import "C_PartJobInfoDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_JobLocationCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *companyLabel;

@property (nonatomic, strong) UILabel *rangeLabel;

@property (nonatomic, strong) UIImageView *userImageView;

@property (nonatomic, strong) UILabel *addressLabel;

- (void)configureWithModel:(C_FullJobDetailModel *)model;


- (void)configureWithPartJobModel:(C_PartJobInfoDetailModel *)model;

@end

NS_ASSUME_NONNULL_END
