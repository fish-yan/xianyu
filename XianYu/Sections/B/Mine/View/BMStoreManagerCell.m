//
//  BMStoreManagerCell.m
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BMStoreManagerCell.h"

@interface BMStoreManagerCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *addLab;
@end

@implementation BMStoreManagerCell

- (void)setModel:(BMStoreManagerModel *)model {
    _model = model;
    self.titleLab.text = model.shopname;
    self.addLab.text = model.address;
    self.statusLab.text = [model.auditstatus isEqualToString:@"1"] ? @"已认证" : @"未认证";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)changeAction:(UIButton *)sender {
    !self.btnAction ?: self.btnAction(sender);
}

@end
