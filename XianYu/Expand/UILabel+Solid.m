//
//  UILabel+Solid.m
//  New_MeiChai
//
//  Created by lmh on 2018/6/4.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "UILabel+Solid.h"

@implementation UILabel (Solid)

- (void)setstring:(NSString *)string lineSpace:(CGFloat)height isAlign:(NSTextAlignment)alignment
{
    if(string.length == 0)
    {
        string = @"";
    }
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:height];
    
    paragraphStyle.alignment = alignment;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    
    [self setAttributedText:attributedString];
}

-(void)setLabelSpaceAlign:(NSTextAlignment)alignment withValue:(NSString*)str withFont:(CGFloat)font  withLineSpace:(CGFloat)lineSpace{
    self.numberOfLines = 0;
    if (str.length == 0) {
        str = @"";
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
    paraStyle.lineSpacing = lineSpace; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.5f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    self.attributedText = attributeStr;
}

@end
