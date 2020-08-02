//
//  C_Mine_DeliverJobListCell.m
//  XianYu
//
//  Created by lmh on 2019/7/7.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_DeliverJobListCell.h"

@implementation C_Mine_DeliverJobListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [JSFactory configureWithView:self.markLabel cornerRadius:Anno750(3) isBorder:YES borderWidth:0.5 borderColor:Color_Green_2886FE];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configureWithModel:(C_Mine_DeliveryListModel *)model
{
    if (model.jobname && model.jobname.length != 0) {
        self.jobLabel.text = model.jobname;
    } else {
        self.jobLabel.text = model.classname;
    }
    if (model.jobtype == 0) {
        self.markLabel.text = @"全职";
    }
    else
    {
        self.markLabel.text = @"兼职";
    }
    
    self.moneyLabel.text = model.wagedes;
    self.logoImageView.hidden = YES;
//    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
    self.companyLabel.text = model.shopname;
    self.rangeLabel.text = model.juli;
    //为查看
    if (model.shopsee == 0) {
        [self.statusLabel setstring:model.shopaudit lineSpace:Anno750(12) isAlign:(NSTextAlignmentLeft)];
        self.statusLabel.textColor = Color_Blue_32A060;
    }
    else if (model.shopsee == 1)
    {
        [self.statusLabel setstring:model.shopaudit lineSpace:Anno750(12) isAlign:(NSTextAlignmentLeft)];
        self.statusLabel.textColor = Color_Gray_828282;
    }
    
}

@end
