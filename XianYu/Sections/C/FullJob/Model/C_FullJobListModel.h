//
//  C_FullJobListModel.h
//  XianYu
//
//  Created by lmh on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_FullJobListModel : BaseModel

@property (nonatomic, strong) NSNumber *id;

@property (nonatomic, assign) int jobtype;
@property (nonatomic, copy) NSString *jobname;
@property (nonatomic, copy) NSString *classname;
@property (nonatomic, copy) NSString *wagedes;
@property (nonatomic, strong) NSArray *welfare;
@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, copy) NSString *juli;

@property(nonatomic, assign) int iscan;


@end

NS_ASSUME_NONNULL_END
