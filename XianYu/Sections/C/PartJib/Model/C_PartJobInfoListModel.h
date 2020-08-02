//
//  C_PartJobInfoListModel.h
//  XianYu
//
//  Created by lmh on 2019/7/27.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_PartJobInfoListModel : BaseModel

@property (nonatomic, strong) NSNumber *id;

@property(nonatomic, assign) NSInteger jobtype;

@property (nonatomic, copy) NSString *jobname;

@property (nonatomic, copy) NSString *classname;

@property (nonatomic, copy) NSString *wagedes;

@property (nonatomic, strong) NSArray *welfare;

@property (nonatomic, assign) NSInteger wagetype;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, copy) NSString *juli;


@end

NS_ASSUME_NONNULL_END
