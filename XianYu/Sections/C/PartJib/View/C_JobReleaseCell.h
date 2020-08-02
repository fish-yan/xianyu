//
//  C_JobReleaseCell.h
//  XianYu
//
//  Created by lmh on 2019/8/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface C_JobReleaseCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *userImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *jobLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, copy) NSString *imgStr;

@end

NS_ASSUME_NONNULL_END
