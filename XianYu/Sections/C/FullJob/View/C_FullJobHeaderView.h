//
//  C_FullJobHeaderView.h
//  XianYu
//
//  Created by lmh on 2019/7/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "C_FullJobSearchView.h"
#import "C_FullJobSelectButtonView.h"
#import "C_BannerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_FullJobHeaderView : UIView<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *bannerView;

@property (nonatomic, strong) C_FullJobSearchView *searchView;

@property (nonatomic, strong) C_FullJobSelectButtonView *jobSelectView;

@property (nonatomic, strong) UIButton *areaButton;

@property (nonatomic, strong) UIButton *distanceButton;

@property (nonatomic, strong) UIButton *releaseButton;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSArray *bannerArray;

@property (nonatomic, strong) UIViewController *viewController;

@property (nonatomic, strong) UIView *backView;

- (void)layoutBtns;

- (void)loadHeadData;

- (void)refreshArearButtonWithModel:(AreaModel *)model;






@end

NS_ASSUME_NONNULL_END
