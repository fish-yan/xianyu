//
//  LTCell.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "LTCell.h"

@interface LTCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *detailTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWidth;

@end

@implementation LTCell

- (void)setModel:(LTCellModel *)model {
    _model = model;
    self.titleLab.text = _model.title;
    self.detailTF.placeholder = _model.placeholder;
    self.detailTF.text = _model.des;
    self.rightWidth.constant = _model.type == LTSelected ? 20 : 0;
    self.detailTF.userInteractionEnabled = _model.type == LTNormal;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)textChange:(UITextField *)sender {
    self.model.des = sender.text;
}

@end
