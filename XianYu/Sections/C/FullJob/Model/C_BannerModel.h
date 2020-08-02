//
//  C_BannerModel.h
//  XianYu
//
//  Created by lmh on 2019/7/29.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_BannerModel : BaseModel

@property(nonatomic, assign) NSInteger id;

@property(nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSNumber *jobid;

@property (nonatomic, copy) NSString *picture;

@property (nonatomic, copy) NSString *connecturl;

@end

NS_ASSUME_NONNULL_END
