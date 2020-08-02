
//
//  BaseModel.m
//  YouShang
//
//  Created by lmh on 201  8/1/25.
//  Copyright © 2018年 lmh. All rights reserved.
//


/**
 *  1 判断是否为3.5inch      320*480
 */
#define ONESCREEN ([UIScreen mainScreen].bounds.size.height == 480)
/**
 *  2 判断是否为4inch        640*1136
 */
#define TWOSCREEN ([UIScreen mainScreen].bounds.size.height == 568)
/**
 *  3 判断是否为4.7inch   375*667   750*1334
 */
#define THREESCREEN ([UIScreen mainScreen].bounds.size.height == 667)
/**
 *  4 判断是否为5.5inch   414*1104   1242*2208
 */


#import "BaseModel.h"
#import <MJExtension.h>

@implementation BaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


- (instancetype)initWithModelDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSDictionary *dic = [self dealWithNullData:dict];
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (BOOL)isLogin
{
    return UserManager.share.token.length != 0;
}

// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }

+ (NSString *)produceImageStringWithOldImageSting:(NSString *)oldString
{
    if (oldString.length == 0) {
        return nil;
    }
    NSMutableString *mString = [NSMutableString stringWithString:oldString];
    
    [mString appendFormat:@"?x-oss-process=image/resize,m_lfit,h_600,w_600/format.png"];
    return mString;
}


-(NSDictionary *)dealWithNullData:(NSDictionary *)dic{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    for (NSString *key in dict.allKeys) {
        NSString *value = dict[key];
        if ([value isEqual:[NSNull null]]) {
            [dict setValue:@"" forKey:key];
        }
    }
    return dict;
}






@end
