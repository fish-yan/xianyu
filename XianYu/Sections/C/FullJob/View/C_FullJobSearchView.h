//
//  C_FullJobSearchView.h
//  XianYu
//
//  Created by lmh on 2019/7/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface C_FullJobSearchView : UIView

@property (nonatomic, strong) UIButton *cityButton;

@property (nonatomic, strong) UILabel *searchLabel;

@property (nonatomic, strong) UIImageView *searchImageView;

@property (nonatomic, strong) UIButton *searchButton;

@property(nonatomic, assign) CGFloat cell_width;

- (void)refreshCityButton:(CityModel *)model;

@end

NS_ASSUME_NONNULL_END
