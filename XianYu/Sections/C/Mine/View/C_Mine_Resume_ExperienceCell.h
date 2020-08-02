//
//  C_Mine_Resume_ExperienceCell.h
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface C_Mine_Resume_ExperienceCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *summaryLabel;

@property (nonatomic, strong) UILabel *companyLabel;

- (void)configureWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
