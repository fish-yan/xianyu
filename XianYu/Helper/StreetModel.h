//
//  StreetModel.h
//  XianYu
//
//  Created by Yan on 2019/7/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StreetModel : BaseModel

@property (nonatomic, copy) NSString *code;

@property(nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *shortname;

@property (assign, nonatomic) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
