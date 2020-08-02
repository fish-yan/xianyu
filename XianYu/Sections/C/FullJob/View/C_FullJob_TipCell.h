//
//  C_FullJob_TipCell.h
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"


NS_ASSUME_NONNULL_BEGIN

@interface C_FullJob_TipCell : UITableViewCell<TTTAttributedLabelDelegate>

@property (nonatomic, strong) UIImageView *tipImageView;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) TTTAttributedLabel *summaryLabel;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *bottomView;

@property (copy, nonatomic) void(^reportAction)(void);

@end

NS_ASSUME_NONNULL_END
