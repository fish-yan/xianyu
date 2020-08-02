//
//  C_PartJobListModel.h
//  XianYu
//
//  Created by lmh on 2019/7/27.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_PartJobListModel : BaseModel

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, copy) NSString *jobname;

@property (nonatomic, copy) NSString *classname;

@property (nonatomic, copy) NSString *wagedes;

@property (nonatomic, assign) NSInteger wagetype;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, assign) CGFloat juli;

@property(nonatomic, assign) NSInteger jobtype;

@property(nonatomic, assign) int iscan;


@end

NS_ASSUME_NONNULL_END
