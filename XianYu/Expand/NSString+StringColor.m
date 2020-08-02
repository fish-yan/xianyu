//
//  NSString+StringColor.m
//  XinBianLi
//
//  Created by lmh on 2017/10/17.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import "NSString+StringColor.h"

@implementation NSString (StringColor)


//从前面截取
+ (NSAttributedString *)setString:(NSString *)string firstColor:(UIColor *)firstColor firstFont:(CGFloat)firstFont cutFromNum:(NSInteger)cutNum secondColor:(UIColor *)secondColor secondFont:(CGFloat)secondFont
{
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc]initWithString:string];
    [attri1 addAttribute:NSForegroundColorAttributeName
                   value:firstColor
                   range:NSMakeRange(0, cutNum)];
    [attri1 addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:firstFont]
                   range:NSMakeRange(0, cutNum)];
    [attri1 addAttribute:NSForegroundColorAttributeName
                   value:secondColor
                   range:NSMakeRange(cutNum, string.length -cutNum)];
    [attri1 addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:secondFont]
                   range:NSMakeRange(cutNum, string.length -cutNum)];
    return attri1;
}

+ (NSAttributedString *)setString:(NSString *)string firstColor:(UIColor *)firstColor firstFont:(CGFloat)firstFont cutFromNum:(NSInteger)cutNum secondColor:(UIColor *)secondColor secondFont:(CGFloat)secondFont thirdFromNum:(NSInteger)thirdNum thirdColor:(UIColor *)thirdColor thirdFont:(CGFloat)thirdFont
{
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc]initWithString:string];
    [attri1 addAttribute:NSForegroundColorAttributeName
                   value:firstColor
                   range:NSMakeRange(0, cutNum)];
    [attri1 addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:firstFont]
                   range:NSMakeRange(0, cutNum)];
    [attri1 addAttribute:NSForegroundColorAttributeName
                   value:secondColor
                   range:NSMakeRange(cutNum, 1)];
    [attri1 addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:secondFont]
                   range:NSMakeRange(cutNum, 1)];
    [attri1 addAttribute:NSForegroundColorAttributeName
                   value:thirdColor
                   range:NSMakeRange(string.length-thirdNum, thirdNum)];
    [attri1 addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:thirdFont]
                   range:NSMakeRange(string.length-thirdNum, thirdNum)];
    return attri1;
}

@end
