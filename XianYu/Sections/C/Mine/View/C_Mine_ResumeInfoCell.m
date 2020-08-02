//
//  C_Mine_ResumeInfoCell.m
//  XianYu
//
//  Created by lmh on 2019/7/7.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_ResumeInfoCell.h"

@implementation C_Mine_ResumeInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithModel:(C_Mine_ResumeModel *)model
{
    self.nameLabel.text = model.name;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
    self.userImageView.backgroundColor = Color_Ground_F5F5F5;
    if ([model.sex isEqualToString:@"男"]) {
        self.sexImageView.image = GetImage(@"icon_c_mine_resume_man");
    }
    else
    {
        self.sexImageView.image = GetImage(@"icon_c_mine_resume_women");
    }
    self.ageLabel.text = [NSString stringWithFormat:@"%ld",model.age];
    self.genderLabel.text = model.educationname;
    self.jobYearLabel.text = model.jobexp;
    self.phoneLabel.text = [NSString stringWithFormat:@"手机号：%@", model.mobile];
    self.wxchatLabel.text = [NSString stringWithFormat:@"微信号：%@", model.wechat];
}

@end
