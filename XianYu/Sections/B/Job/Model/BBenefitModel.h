//
//  BBenefitModel.h
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBenefitModel : NSObject
@property (copy, nonatomic) NSString *key;
@property (copy, nonatomic) NSString *pkey;
@property (copy, nonatomic) NSString *value;
@property (assign, nonatomic) BOOL isSelected;
@property (strong, nonatomic) NSMutableArray *list;
@end

NS_ASSUME_NONNULL_END
