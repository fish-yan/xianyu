//
//  NSString+StringColor.h
//  XinBianLi
//
//  Created by lmh on 2017/10/17.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringColor)

+ (NSAttributedString *)setString:(NSString *)string firstColor:(UIColor *)firstColor firstFont:(CGFloat)firstFont cutFromNum:(NSInteger)cutNum secondColor:(UIColor *)secondColor secondFont:(CGFloat)secondFont;

+ (NSAttributedString *)setString:(NSString *)string firstColor:(UIColor *)firstColor firstFont:(CGFloat)firstFont cutFromNum:(NSInteger)cutNum secondColor:(UIColor *)secondColor secondFont:(CGFloat)secondFont thirdFromNum:(NSInteger)thirdNum thirdColor:(UIColor *)thirdColor thirdFont:(CGFloat)thirdFont;

@end
