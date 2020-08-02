//
//  BMMoreServiceMode.h
//  XianYu
//
//  Created by Yan on 2019/8/2.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMMoreServiceMode : BaseModel
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *moblie;
@property (copy, nonatomic) NSString *email;
@property (strong, nonatomic) NSMutableArray<NSDictionary*> *company;
@end

NS_ASSUME_NONNULL_END
