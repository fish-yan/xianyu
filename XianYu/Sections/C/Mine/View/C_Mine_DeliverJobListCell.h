//
//  C_Mine_DeliverJobListCell.h
//  XianYu
//
//  Created by lmh on 2019/7/7.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_Mine_DeliveryListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface C_Mine_DeliverJobListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (void)configureWithModel:(C_Mine_DeliveryListModel *)model;

@end

NS_ASSUME_NONNULL_END
