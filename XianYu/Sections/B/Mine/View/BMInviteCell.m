//
//  BMInviteCell.m
//  XianYu
//
//  Created by Yan on 2019/9/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BMInviteCell.h"

@interface BMInviteCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *statusLabs;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *arrowLabs;
@property (weak, nonatomic) IBOutlet UILabel *firstLab;

@end

@implementation BMInviteCell
- (void)setModel:(BMFriendModel *)model {
    _model = model;
    self.nameLab.text = model.name;
    [self.photoV sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    for (UILabel *lab in self.statusLabs) {
        lab.textColor = UIColorFromRGB(0xD2D2D2);
        lab.backgroundColor = UIColorFromRGB(0xF5F5F5);
        lab.layer.borderWidth = 0;
    }
    for (UILabel *arrow in self.arrowLabs) {
        arrow.textColor = UIColorFromRGB(0xD2D2D2);
    }
    if ([model.friendStatus isEqualToString:@"0"]) {
        self.firstLab.textColor = UIColorFromRGB(0x32A060);
        self.firstLab.backgroundColor = UIColorFromRGB(0xEFF7F2);
        self.firstLab.layer.borderWidth = 1;
    } else {
        for (UILabel *lab in self.statusLabs) {
            lab.textColor = UIColorFromRGB(0x32A060);
            lab.backgroundColor = UIColorFromRGB(0xEFF7F2);
            lab.layer.borderWidth = 1;
        }
        for (UILabel *arrow in self.arrowLabs) {
            arrow.textColor = UIColorFromRGB(0x32A060);
        }
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

@end
