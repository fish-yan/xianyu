//
//  BJobPriceModel.h
//  XianYu
//
//  Created by Yan on 2019/7/23.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BJobPriceModel : BaseModel

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *no;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *label;
@property (copy, nonatomic) NSString *normalmaxnum;
@property (copy, nonatomic) NSString *linkupmaxnum;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *discount;
@property (copy, nonatomic) NSString *numday;
@property (copy, nonatomic) NSString *dailypostmaxnum;
@property (copy, nonatomic) NSString *grade;
@property (copy, nonatomic) NSString *price2;
@end

NS_ASSUME_NONNULL_END
