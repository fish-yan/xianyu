//
//  C_FullJobSelectCityCell.h
//  XianYu
//
//  Created by lmh on 2019/7/14.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface C_FullJobSelectCityCell : UITableViewCell

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIView *bottomLineView;

- (void)remarkNameLabel;



@end

NS_ASSUME_NONNULL_END
