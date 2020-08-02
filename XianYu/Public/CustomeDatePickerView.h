//
//  CustomeDatePickerView.h
//  YouShang
//
//  Created by lmh on 2018/8/3.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomeDatePickerViewDelagate<NSObject>

- (void)configureWithDateString:(NSString *)dataString;


@end

@interface CustomeDatePickerView : UIView

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, assign) id<CustomeDatePickerViewDelagate>delegate;

@property (nonatomic, strong) UIViewController *viewController;

@property (nonatomic, copy) NSString *currentString;


@end
