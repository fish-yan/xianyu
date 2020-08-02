//
//  C_Mine_ResumeModel.m
//  XianYu
//
//  Created by lmh on 2019/7/14.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_ResumeModel.h"

@implementation C_Mine_ResumeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
