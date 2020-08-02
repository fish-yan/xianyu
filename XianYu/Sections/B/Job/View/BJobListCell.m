
//
//  B_JobManagerListCell.m
//  XianYu
//
//  Created by lmh on 2019/7/9.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BJobListCell.h"
#import "XianYu-Swift.h"

@interface BJobListCell()

@property (nonatomic, strong) IBOutlet UILabel *jobLab;

@property (nonatomic, strong) IBOutlet UILabel *typeLab;

@property (nonatomic, strong) IBOutlet UILabel *timeLab;

@property (nonatomic, strong) IBOutlet UIButton *leftBtn;

@property (nonatomic, strong) IBOutlet UIButton *rightBtn;

@property (nonatomic, strong) IBOutlet UILabel *statusLab;

@property (weak, nonatomic) IBOutlet UILabel *viewCountLab;

@property (weak, nonatomic) IBOutlet UILabel *sendCountLab;

@property (weak, nonatomic) IBOutlet UILabel *chatCountLab;

@end

@implementation BJobListCell

- (void)setModel:(BJobModel *)model {
    _model = model;
    if (model.jobname && model.jobname.length != 0) {
        self.jobLab.text = model.jobname;
    } else {
        self.jobLab.text = model.classname;
    }
    self.typeLab.text = [model.jobtype isEqualToString:@"0"] ? @"全职" : @"兼职";
    
    if ([model.status isEqualToString:@"3"] ||
        [model.status isEqualToString:@"4"]) {
        self.timeLab.text = @"";
    } else {
        NSString *dateStr = @"";
        if (model.expiredate && model.expiredate.length != 0) {
            if (model.expiredate.length >= 10) {
                dateStr = [model.expiredate substringToIndex:10];
            } else {
                dateStr = model.expiredate;
            }
            self.timeLab.text = [NSString stringWithFormat:@"到期时间%@", dateStr];
        } else {
            self.timeLab.text = @"";
        }
    }
    
    self.viewCountLab.text = [NSString stringWithFormat:@"%@人浏览", model.browsenum];
    self.sendCountLab.text = [NSString stringWithFormat:@"%@人投递", model.deliverynum];
    self.chatCountLab.text = [NSString stringWithFormat:@"%@人沟通", model.cationnum];
    self.statusLab.text = model.status;
    self.leftBtn.hidden = YES;
    self.rightBtn.hidden = NO;
    if ([model.status isEqualToString:@"0"]) {
        self.statusLab.text = @"已下线";
        self.statusLab.textColor = Color_Black_A5A5A5;
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"重新上线" forState:UIControlStateNormal];
    } else if ([model.status isEqualToString:@"1"]) {
        self.statusLab.text = @"招聘中";
        self.statusLab.textColor = Color_Black_323232;
        self.leftBtn.hidden = NO;
        [self.leftBtn setTitle:@"分享" forState:UIControlStateNormal];
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"下线" forState:UIControlStateNormal];
    } else if ([model.status isEqualToString:@"2"]) {
        self.statusLab.text = @"已到期";
        self.statusLab.textColor = Color_Red_ED4545;
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"续费上线" forState:UIControlStateNormal];
    } else if ([model.status isEqualToString:@"3"] ||
               [model.status isEqualToString:@"4"]) {
        self.statusLab.text = @"未开放";
        self.statusLab.textColor = Color_Red_ED4545;
        self.rightBtn.hidden = NO;
        [self.rightBtn setTitle:@"马上开放" forState:UIControlStateNormal];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnAction:(UIButton *)sender {
    !self.btnAction ?: self.btnAction(sender);
}



@end
