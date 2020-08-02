//
//  UILabel+Solid.h
//  New_MeiChai
//
//  Created by lmh on 2018/6/4.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Solid)

- (void)setstring:(NSString *)string lineSpace:(CGFloat)height isAlign:(NSTextAlignment)alignment;

-(void)setLabelSpaceAlign:(NSTextAlignment)alignment withValue:(NSString*)str withFont:(CGFloat)font  withLineSpace:(CGFloat)lineSpace;

@end
