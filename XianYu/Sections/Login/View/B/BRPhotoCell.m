//
//  BRPhotoCell.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRPhotoCell.h"

@interface BRPhotoCell()

@property (weak, nonatomic) IBOutlet UIImageView *photoBtn;

@end

@implementation BRPhotoCell

- (void)setPhoto:(NSString *)photo {
    _photo = photo;
    NSString *str = [photo stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.photoBtn sd_setImageWithURL:[NSURL URLWithString:str]];
    self.photoBtn.backgroundColor = Color_Ground_F5F5F5;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)photoAction:(UIButton *)sender {
    
}

@end
