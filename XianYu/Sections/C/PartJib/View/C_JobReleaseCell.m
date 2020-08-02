//
//  C_JobReleaseCell.m
//  XianYu
//
//  Created by lmh on 2019/8/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_JobReleaseCell.h"

@interface C_JobReleaseCell()

@property (nonatomic, strong) UIImageView *img1;

@property (nonatomic, strong) UIImageView *img2;

@property (nonatomic, strong) UIImageView *img3;

@property (nonatomic, strong) UIImageView *img4;

@end

@implementation C_JobReleaseCell

- (void)setImgStr:(NSString *)imgStr {
    _imgStr = imgStr;
    if (!imgStr || imgStr.length == 0) {
        self.img1.hidden = YES;
        self.img2.hidden = YES;
        self.img3.hidden = YES;
        self.img4.hidden = YES;
        return;
    }
    NSArray *imgs = [imgStr componentsSeparatedByString:@","];
    if (imgs.count > 0) {
        self.img1.hidden = NO;
        [self.img1 sd_setImageWithURL:[NSURL URLWithString:imgs[0]]];
    }
    if (imgs.count > 1) {
        self.img2.hidden = NO;
        [self.img2 sd_setImageWithURL:[NSURL URLWithString:imgs[1]]];
    }
    if (imgs.count > 2) {
        self.img3.hidden = NO;
        [self.img3 sd_setImageWithURL:[NSURL URLWithString:imgs[2]]];
    }
    if (imgs.count > 3) {
        self.img4.hidden = NO;
        [self.img4 sd_setImageWithURL:[NSURL URLWithString:imgs[3]]];
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = Color_White;
        self.layer.masksToBounds = YES;
        
    }
    return self;
}

- (void)imgTapAction:(UITapGestureRecognizer *)tap {
    UIImageView *imgV = (UIImageView *)tap.view;
    FYBigImgViewController *bigVC = [[FYBigImgViewController alloc] init];
    bigVC.img = imgV.image;
    [[UIViewController  visibleViewController].navigationController pushViewController:bigVC animated:YES];
}

- (void)createUI
{
    self.titleLabel = [JSFactory creatLabelWithTitle:@"职位发布者" textColor:Color_Black_464646 textFont:font750(40) textAlignment:(NSTextAlignmentLeft)];
    self.userImageView = [JSFactory creatImageViewWithImageName:nil];
    self.userImageView.backgroundColor = Color_Ground_F5F5F5;
    [JSFactory configureWithView:self.userImageView cornerRadius:Anno750(50) isBorder:NO borderWidth:0 borderColor:nil];
    self.nameLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_323232 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.jobLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_878787 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    self.lineView = [JSFactory createLineView];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTapAction:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTapAction:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTapAction:)];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTapAction:)];
    self.img1 = [[UIImageView alloc]init];
    self.img1.userInteractionEnabled = YES;
    [self.img1 addGestureRecognizer:tap1];
    self.img1.contentMode = UIViewContentModeScaleToFill;
    self.img2 = [[UIImageView alloc]init];
    self.img2.userInteractionEnabled = YES;
    [self.img2 addGestureRecognizer:tap2];
    self.img2.contentMode = UIViewContentModeScaleToFill;
    self.img3 = [[UIImageView alloc]init];
    self.img3.userInteractionEnabled = YES;
    [self.img3 addGestureRecognizer:tap3];
    self.img3.contentMode = UIViewContentModeScaleToFill;
    self.img4 = [[UIImageView alloc]init];
    self.img4.userInteractionEnabled = YES;
    [self.img4 addGestureRecognizer:tap4];
    self.img4.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.titleLabel];
    [self addSubview:self.userImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.jobLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.img1];
    [self addSubview:self.img2];
    [self addSubview:self.img3];
    [self addSubview:self.img4];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(44)));
        make.top.equalTo(@(Anno750(31)));
        make.height.equalTo(@(Anno750(56)));
    }];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Anno750(20));
        make.size.mas_equalTo(CGSizeMake(Anno750(100), Anno750(100)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(Anno750(10));
        make.top.equalTo(self.userImageView);
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.jobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(Anno750(10));
        make.bottom.equalTo(self.userImageView);
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_bottom).offset(Anno750(20));
        make.left.equalTo(@(Anno750(44)));
        make.width.equalTo(@((KScreenWidth - Anno750(12 * 3 + 44 * 2))/4));
        make.height.equalTo(@(Anno750(120)));
    }];
    [self.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_bottom).offset(Anno750(20));
        make.left.equalTo(self.img1.mas_right).offset(Anno750(12));
        make.height.equalTo(@(Anno750(120)));
        make.width.equalTo(@((KScreenWidth - Anno750(12 * 3 + 44 * 2))/4));
    }];
    [self.img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_bottom).offset(Anno750(20));
        make.left.equalTo(self.img2.mas_right).offset(Anno750(12));
        make.height.equalTo(@(Anno750(120)));
        make.width.equalTo(@((KScreenWidth - Anno750(12 * 3 + 44 * 2))/4));
    }];
    [self.img4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_bottom).offset(Anno750(20));
        make.left.equalTo(self.img3.mas_right).offset(Anno750(12));
        make.height.equalTo(@(Anno750(120)));
        make.width.equalTo(@((KScreenWidth - Anno750(12 * 3 + 44 * 2))/4));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
}

@end
