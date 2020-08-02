//
//  B_News_ResumeView.h
//  XianYu
//
//  Created by lmh on 2019/7/30.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "B_News_ResumeModel.h"
#import "C_News_JobInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface B_News_ResumeView : UIView

@property (nonatomic, strong) UILabel *jobLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UILabel *infoLabel;

@property (nonatomic, strong) UILabel *wantJobLabel;

@property (nonatomic, strong) UILabel *jobStatusLabel;

@property (nonatomic, strong) UIImageView *bottomImageView;

@property (nonatomic, strong) UIButton *jobButton;

@property (nonatomic, strong) UIButton *clickButton;

- (void)configureWithModel:(B_News_ResumeModel *)model with:(C_News_JobInfoModel *)jobModel;

@end

NS_ASSUME_NONNULL_END
