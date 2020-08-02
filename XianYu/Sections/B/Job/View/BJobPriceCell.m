//
//  BJobPriceCell.m
//  XianYu
//
//  Created by Yan on 2019/7/23.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BJobPriceCell.h"

@interface BJobPriceCell ()
@property (weak, nonatomic) IBOutlet UIView *bgV;
@property (weak, nonatomic) IBOutlet UILabel *monthLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImgV;

@end

@implementation BJobPriceCell

- (void)setModel:(BJobPriceModel *)model {
    _model = model;
    self.monthLab.text = model.name;
    self.priceLab.text = [NSString stringWithFormat:@"%@元", model.price];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.selectedImgV.hidden = !isSelected;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
