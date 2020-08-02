//
//  C_Mine_DeliveryListModel.h
//  XianYu
//
//  Created by lmh on 2019/7/22.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_Mine_DeliveryListModel : BaseModel

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *jobid;
@property (nonatomic, strong) NSNumber *shopid;
@property(nonatomic, assign) NSInteger jobtype;
@property (nonatomic, copy) NSString *jobname;
@property (nonatomic, copy) NSString *classname;
@property (nonatomic, copy) NSString *shopname;
@property (nonatomic, copy) NSString *shopaudit;
@property (nonatomic, copy) NSString *wagedes;
@property (nonatomic, copy) NSString *juli;
//private Byte shopsee;//0未查看 1已查看
@property(nonatomic, assign) NSInteger shopsee;;




@end

NS_ASSUME_NONNULL_END
