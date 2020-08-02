//
//  UserInfoModel.m
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"photo"]) {
        self.photourl = value;
    }
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"photourl" : @[@"photo", @"photourl"]};
}

@end
