//
//  CustomErrorView.h
//  YouShang
//
//  Created by lmh on 2018/4/27.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomErrorView : UIView

@property (nonatomic, strong) UIImageView *errorImageView;

@property (nonatomic, strong) UILabel *errorLabel;

@property (nonatomic, strong) UIButton *errorButton;

- (instancetype)initWithFrame:(CGRect)frame isError:(BOOL)isError;

@end
