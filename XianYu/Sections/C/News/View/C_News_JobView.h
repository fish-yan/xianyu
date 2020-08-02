//
//  C_News_JobView.h
//  XianYu
//
//  Created by lmh on 2019/7/30.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_News_JobInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_News_JobView : UIView

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *companyLabe;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UIButton *clickButton;



- (void)configureWithModel:(C_News_JobInfoModel *)model;


@end

NS_ASSUME_NONNULL_END
