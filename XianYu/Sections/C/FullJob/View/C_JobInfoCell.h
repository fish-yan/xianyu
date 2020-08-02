//
//  C_JobInfoCell.h
//  XianYu
//
//  Created by lmh on 2019/6/27.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_FullJobDetailModel.h"
#import "C_PartJobInfoDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_JobInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, strong) UILabel *markLabel1;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *ageLabel;

@property (nonatomic, strong) UILabel *genderLabel;

@property (nonatomic, strong) UILabel *jobYearLabel;

@property (nonatomic, strong) UIView *lineView;


- (void)configureWithModel:(C_FullJobDetailModel *)model;


- (void)configureWithPartJobModel:(C_PartJobInfoDetailModel *)model;

- (CGFloat)createWealfareLabelView:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
