//
//  C_FullJobTypeSelectHeaderView.h
//  XianYu
//
//  Created by lmh on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface C_FullJobTypeSelectHeaderView : UIView

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIButton *modifyButton;

@property (nonatomic, strong) RACSubject *clearSubject;

@property (nonatomic, strong) RACSubject *removeSubject;


- (CGFloat)createSelectButtonArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
