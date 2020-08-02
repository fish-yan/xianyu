//
//  ChatHeaderCell.h
//  XianYu
//
//  Created by lmh on 2019/7/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatHeaderCell : RCMessageBaseCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UILabel *companyNameLabel;

@property (nonatomic, strong) UILabel *rangeLabel;


@end

NS_ASSUME_NONNULL_END
