//
//  SecurityHelper.m
//  jianshebao
//
//  Created by 吴孔锐 on 16/8/11.
//  Copyright © 2016年 lmh. All rights reserved.
//

#import "SecurityHelper.h"

@implementation SecurityHelper
+ (NSArray *)sortString:(NSArray *)array{
    NSMutableArray * temp = [NSMutableArray arrayWithArray:array];
    for (int i = 0; i < temp.count - 1; i++) {
        for (int j = i+1; j < temp.count; j++) {
            NSComparisonResult ret = [temp[i] compare:temp[j]];
            if (ret == NSOrderedDescending) {
                [temp exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    return temp;
}
+ (NSString *)montage:(NSDictionary *)params keys:(NSArray *)keys{
    NSString * temp;
    for (int i = 0; i<keys.count; i++) {
        NSString * key = keys[i];
        if (![key isEqualToString:@"sign"] && [params objectForKey:key] && ![[params objectForKey:key] isEqualToString:@""]){
            NSString * paramStr = [NSString stringWithFormat:@"%@=%@",key,params[key]];
            if (i == 0) {
                temp = paramStr;
            }else{
                temp = [NSString stringWithFormat:@"%@&%@",temp,paramStr];
            }
        }
    }
    return temp;
}
@end
