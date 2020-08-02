//
//  C_PartJobTypeSelectView.h
//  XianYu
//
//  Created by lmh on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface C_PartJobTypeSelectView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) UIButton *modifyButton;

@property (nonatomic, strong) RACSubject *clickSubject;

@property (nonatomic, strong) UIButton *areaButton;

@property (nonatomic, strong) UIButton *typeButton;

@property (nonatomic, strong) UIButton *paixunButton;

@property (nonatomic, strong) UIView *lineView;


- (void)createJobItemViewWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
