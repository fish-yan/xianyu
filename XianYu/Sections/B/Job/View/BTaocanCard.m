//
//  BTaocanCard.m
//  XianYu
//
//  Created by Yan on 2019/9/13.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BTaocanCard.h"
#import "XianYu-Swift.h"

@interface BTaocanCard ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImgV;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right;


@property (strong, nonatomic)  FYGrandientView *gView;
@end

@implementation BTaocanCard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadOneView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self loadOneView];
    }
    return self;
}

- (void)loadOneView {
    self.gView = [[UINib nibWithNibName:@"BTaocanCard" bundle:nil] instantiateWithOwner:self options:nil].firstObject;
    self.gView.frame = self.bounds;
    [self addSubview:self.gView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gView.frame = self.bounds;
}

- (IBAction)btnAction:(UIButton *)sender {
    !self.btnAction ?: self.btnAction(self);
}

- (void)setModel:(BJobPriceModel *)model {
    _model = model;
    self.titleLab.text = model.name;
    self.priceLab.text = model.price2;
    self.detailLab.text = model.label;
    self.desLab.attributedText = [[NSAttributedString alloc] initWithData:[model.desc dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [self setTextColor];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.selectedImgV.hidden = !isSelected;
}

- (void)setTextColor {
    
    NSDictionary *startColors = @{@"1":UIColorFromRGB(0xD7B69D), @"2":UIColorFromRGB(0xE9CE74), @"3":UIColorFromRGB(0xB7B9C1), @"4":UIColorFromRGB(0x474747)};
    NSDictionary *endColors = @{@"1":UIColorFromRGB(0xEFD8C0), @"2":UIColorFromRGB(0xF3DD94), @"3":UIColorFromRGB(0xD2D6DD), @"4":UIColorFromRGB(0x808080)};
    NSDictionary *titleColor = @{@"1":UIColorFromRGB(0x323232), @"2":UIColorFromRGB(0x323232), @"3":UIColorFromRGB(0xFFFFFF), @"4":UIColorFromRGB(0xFFFFFF)};
    NSDictionary *labelColor = @{@"1":UIColorFromRGB(0xE02020), @"2":UIColorFromRGB(0xE02020), @"3":UIColorFromRGB(0xE02020), @"4":UIColorFromRGB(0xF7B500)};
    NSDictionary *priceColor = @{@"1":UIColorFromRGB(0x323232), @"2":UIColorFromRGB(0x323232), @"3":UIColorFromRGB(0x323232), @"4":UIColorFromRGB(0xffffff)};
    NSDictionary *desColor = @{@"1":UIColorFromRGB(0x75695F), @"2":UIColorFromRGB(0x75695F), @"3":UIColorFromRGB(0x75695F), @"4":UIColorFromRGB(0xffffff)};
    self.bgV.startColor = startColors[self.model.grade];
    self.bgV.endColor = endColors[self.model.grade];
    self.bgV.startPoint = CGPointMake(0, 0);
    self.bgV.endPoint = CGPointMake(1, 0);
    self.titleLab.textColor = titleColor[self.model.grade];
    self.detailLab.textColor = labelColor[self.model.grade];
    self.priceLab.textColor = priceColor[self.model.grade];
    self.desLab.textColor = desColor[self.model.grade];
}

@end
