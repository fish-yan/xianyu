//
//  LabelOfLabelCell.h
//  XianYu
//
//  Created by lmh on 2019/6/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LabelOfLabelCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UILabel *summaryLabel;

@property (nonatomic, strong) UITextField *printField;

@property (nonatomic, strong) UIImageView *userImageView;

@property (nonatomic, strong) UIView *lineView;


- (void)configureWithNameStr:(NSString *)nameStr withIsField:(BOOL)isField withPlaceHolder:(NSString *)placeHolder withSummarStr:(NSString *)summaryStr;

@end

NS_ASSUME_NONNULL_END
