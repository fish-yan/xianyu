//
//  BRTradeCell.m
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRTradeCell.h"

@implementation BRTradeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.titleLab.textColor = _isSelected ? Color_Blue_32A060 : Color_Gray_828282;
    self.titleLab.backgroundColor = _isSelected ? Color_Green_EFF7F2 : Color_Ground_F5F5F5;
}

@end
