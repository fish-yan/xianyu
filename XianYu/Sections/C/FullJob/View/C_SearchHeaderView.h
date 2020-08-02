//
//  C_SearchHeaderView.h
//  XianYu
//
//  Created by lmh on 2019/7/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface C_SearchHeaderView : UIView

@property (nonatomic, strong) UIButton *cityButton;

@property (nonatomic, strong) UIButton *distanceButton;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, strong) UITableView *rightTableView;

@end

NS_ASSUME_NONNULL_END
