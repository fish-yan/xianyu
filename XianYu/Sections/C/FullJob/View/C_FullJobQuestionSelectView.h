//
//  C_FullJobQuestionSelectView.h
//  XianYu
//
//  Created by lmh on 2019/7/14.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_FullJobSelectCityCell.h"
#import "C_FullJobSelectChildCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SelectQuestionType_City,
    SelectQuestionType_Distance,
    SelectQuestionType_Release,
} SelectQuestionType;

@interface C_FullJobQuestionSelectView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *leftTableView;

@property(nonatomic, assign) NSInteger selectNum;


@property (nonatomic, assign) SelectQuestionType selectType;


@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) RACSubject *mySubject;

- (void)loadCityName:(NSString *)cityName withNum:(NSInteger)num;

- (void)loadPaymentWithNum:(NSInteger)num;

- (void)loadOtherWithNum:(NSInteger)num;

@end

NS_ASSUME_NONNULL_END
