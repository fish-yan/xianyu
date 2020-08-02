//
//  BTaocanCard.h
//  XianYu
//
//  Created by Yan on 2019/9/13.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BJobPriceModel.h"
#import "XianYu-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface BTaocanCard : UIView
@property (weak, nonatomic) IBOutlet FYGrandientView *bgV;

@property (strong, nonatomic) BJobPriceModel *model;
@property (assign, nonatomic) BOOL isSelected;
@property (nonatomic, copy) void(^btnAction)(BTaocanCard *v);

@end

NS_ASSUME_NONNULL_END
