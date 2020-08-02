//
//  XYTagsView.m
//  XianYu
//
//  Created by Yan on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "XYTagsView.h"

@implementation XYTagsView


+ (CGFloat)initTagsWith:(UIView *)view array:(NSArray *)array {
    
    for (UIView * v in view.subviews) {
        [v removeFromSuperview];
    }
    
    CGFloat label_x = 0;
    CGFloat label_y = 0;
    CGFloat label_h = 26;
    CGFloat label_w = 0;
    CGFloat space = 0;
    
    for (int i = 0; i < array.count; i++) {
        NSString *str = array[i];
        CGSize size = [JSFactory getSize:str maxSize:(CGSizeMake(CGFLOAT_MAX, label_h)) font:[UIFont systemFontOfSize:13]];
        label_x += (label_w + space);
        if (label_x + size.width + 20  > view.frame.size.width) {
            label_x = 0;
            label_y += 36;
        }
        label_w = size.width + 20;
        space = 10;
        UILabel *label = [JSFactory creatLabelWithTitle:str textColor:Color_Blue_32A060 textFont:13 textAlignment:(NSTextAlignmentCenter)];
        label.frame = CGRectMake(label_x, label_y, label_w, label_h);
        [JSFactory configureWithView:label cornerRadius:2 isBorder:NO borderWidth:0 borderColor:nil];
        label.backgroundColor = Color_Green_EFF7F2;
        [view addSubview:label];
    }
    
    return label_y + label_h;
}

@end
