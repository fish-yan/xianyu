//
//  CityMarkCell.h
//  New_MeiChai
//
//  Created by lmh on 2018/6/13.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityMarkCellDelegate<NSObject>

- (void)clickCityButtonSection:(NSInteger)section withTag:(NSInteger)tag;

@end

@interface CityMarkCell : UITableViewCell

@property (nonatomic, weak)id<CityMarkCellDelegate>delegate;

@property (nonatomic, strong) UIViewController *viewController;


- (CGFloat)configureWithArray:(NSArray *)array section:(NSInteger)section;

@end
