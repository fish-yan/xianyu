//
//  C_MineLIstCell.h
//  XianYu
//
//  Created by lmh on 2019/7/3.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface C_MineLIstCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *progressLab;

- (void)configureWithImageStr:(NSString *)imageStr withNameStr:(NSString *)nameStr;

@end

NS_ASSUME_NONNULL_END
