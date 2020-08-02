//
//  C_PartJobSelectView.h
//  XianYu
//
//  Created by lmh on 2019/7/22.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface C_PartJobSelectView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) CityModel *cityModel;

@property (nonatomic, strong) RACSubject *selectSubject;

@property(nonatomic, assign) C_PartJobTableViewType queType;

@property(nonatomic, assign) NSInteger selectNum;

- (void)refreshTableViewType:(C_PartJobTableViewType)type withName:(NSString *)cityName withDefautNum:(NSInteger)num;

@end

NS_ASSUME_NONNULL_END
