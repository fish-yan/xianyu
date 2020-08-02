//
//  NSString+StringHeight.h
//  New_MeiChai
//
//  Created by lmh on 2018/6/4.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringHeight)


-(CGFloat)getSpaceLabelWothFont:(UIFont*)font withWidth:(CGFloat)width lineSpace:(CGFloat)lineSpace;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+(BOOL)isEmpey:(NSString *)text;

@end
