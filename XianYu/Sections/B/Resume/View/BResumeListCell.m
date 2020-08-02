//
//  BResumeListCell.m
//  XianYu
//
//  Created by Yan on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BResumeListCell.h"

@interface BResumeListCell ()
@property (weak, nonatomic) IBOutlet UILabel *jobLab;
@property (weak, nonatomic) IBOutlet UIImageView *photoImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *sexLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *eduLab;
@property (weak, nonatomic) IBOutlet UILabel *expLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *jobStatusLab;
@property (weak, nonatomic) IBOutlet UIView *wantJobV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@end

@implementation BResumeListCell

- (void)setModel:(BResumeModel *)model {
    _model = model;
    if (model.jobname && model.jobname.length != 0) {
        self.jobLab.text = model.jobname;
    } else {
        self.jobLab.text = model.classname;
    }
    self.jobLab.text = model.classname;
    [self.photoImgV sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    self.nameLab.text = model.name;
    self.sexLab.text = model.sex;
    self.ageLab.text = model.age;
    self.eduLab.text = model.educationname;
    self.expLab.text = model.jobexp;
    if ([model.shopsee isEqualToString:@"0"]) {
        self.statusLab.text = @"未查看";
        self.statusLab.textColor = UIColorFromRGB(0xF53C3C);
    } else {
        self.statusLab.text = @"已查看";
        self.statusLab.textColor = UIColorFromRGB(0xA5A5A5);
    }
    self.jobStatusLab.text = model.jobstatus;
    NSArray *wantjobs = [model.wantjob componentsSeparatedByString:@"&"];
    CGFloat h = [XYTagsView initTagsWith:self.wantJobV array:wantjobs];
    self.height.constant = h;
    
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
