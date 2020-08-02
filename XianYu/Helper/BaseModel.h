//
//  BaseModel.h
//  YouShang
//
//  Created by lmh on 2018/1/25.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

@interface BaseModel : NSObject<NSCopying, NSCoding>

- (instancetype)initWithModelDict:(NSDictionary *)dict;

+ (BOOL)isLogin;

+ (NSString *)produceImageStringWithOldImageSting:(NSString *)oldString;

@end
