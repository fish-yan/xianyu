//
//  SecurityHelper.h
//  jianshebao
//
//  Created by 吴孔锐 on 16/8/11.
//  Copyright © 2016年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityHelper : NSObject
/**
 * 字符串按首字母排序
 */
+ (NSArray *)sortString:(NSArray *)array;
/**
 * 将字典里的所有的值 转为字符串
 */
+ (NSString *)montage:(NSDictionary *)params keys:(NSArray *)keys;
@end
