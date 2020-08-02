//
//  XYAlertDatePickerView.h
//  XianYu
//
//  Created by lmh on 2019/7/24.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PGDatePicker/PGDatePickManager.h>


typedef void (^CompleteBlockData)(id returnData);
NS_ASSUME_NONNULL_BEGIN

@interface XYAlertDatePickerView : UIView<PGDatePickerDelegate>

@property (nonatomic, strong) PGDatePickManager *datePickManager;

@property (nonatomic, strong) PGDatePicker *datePicker;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIButton *sureBUtton;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSDate *currentDate;

@property (nonatomic, copy) NSString *timeStr;



+ (XYAlertDatePickerView *)ShowAlertDatePickerWithNameStr:(NSString *)nameStr  withViewController:(UIViewController *)viewController withSureBlock:(CompleteBlockData)sureBlock;

@end

NS_ASSUME_NONNULL_END
