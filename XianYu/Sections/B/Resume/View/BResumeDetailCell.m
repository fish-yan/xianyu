
//
//  BResumeDetailCell.m
//  XianYu
//
//  Created by Yan on 2019/7/26.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BResumeDetailCell.h"

@interface BResumeDetailCell()
@property (weak, nonatomic) IBOutlet UILabel *workDateLab;
@property (weak, nonatomic) IBOutlet UILabel *workTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *workNameLab;
@property (weak, nonatomic) IBOutlet UILabel *workCompanyLab;
@end

@implementation BResumeDetailCell

- (void)setModel:(BResumeJobExpModel *)model {
    _model = model;
    self.workDateLab.text = [NSString stringWithFormat:@"%@-%@", model.startdate, model.enddate];
    self.workTypeLab.text = model.jobType;
    self.workNameLab.text = model.jobname;
    self.workCompanyLab.text = model.shopname;
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
