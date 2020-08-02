//
//  C_FullJobSelectButtonView.h
//  XianYu
//
//  Created by lmh on 2019/7/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface C_FullJobSelectButtonView : UIView


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) UIButton *modifyButton;

@property (nonatomic, strong) RACSubject *clickSubject;


- (void)createJobItemViewWithArray:(NSArray *)array;


@end

NS_ASSUME_NONNULL_END
