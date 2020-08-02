//
//  C_FullJobSearchView.m
//  XianYu
//
//  Created by lmh on 2019/7/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJobSearchView.h"

@implementation C_FullJobSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = Color_White;
    }
    return self;
}

- (void)createUI
{
    self.cityButton = [JSFactory creatButtonWithTitle:@"上海" textFont:font750(28) titleColor:Color_Black_464646 backGroundColor:Color_White];
    [self.cityButton setImage:GetImage(@"icon_c_fulljob_city_down") forState:(UIControlStateNormal)];
    
    self.searchImageView = [JSFactory creatImageViewWithImageName:@"icon_c_fulljob_search"];
    self.searchLabel = [JSFactory creatLabelWithTitle:@"搜索职位或公司" textColor:Color_Black_A5A5A5 textFont:font750(26) textAlignment:(NSTextAlignmentCenter)];
    [JSFactory configureWithView:self.searchLabel cornerRadius:Anno750(6) isBorder:NO borderWidth:0 borderColor:nil];
    self.searchLabel.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.searchButton = [JSFactory creatButtonWithNormalImage:nil selectImage:nil];
    [self addSubview:self.cityButton];
    [self addSubview:self.searchImageView];
    [self addSubview:self.searchLabel];
    [self addSubview:self.searchButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(10)));
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        if (self.cell_width > 0) {
            make.width.equalTo(@(self.cell_width));
        }
        else
        {
            make.width.equalTo(@(Anno750(100)));
        }
    }];
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(30)));
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(Anno750(40), Anno750(40)));
    }];
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cityButton.mas_right).offset(Anno750(30));
        make.right.equalTo(self.searchImageView.mas_left).offset(-Anno750(30));
        make.top.equalTo(@(Anno750(18)));
        make.bottom.equalTo(@(-Anno750(18)));
    }];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cityButton.mas_right);
        make.top.bottom.right.equalTo(@0);
    }];
    [self.cityButton layoutButtonWithImageStyle:(ZJButtonImageStyleRight) imageTitleToSpace:Anno750(10)];
}

- (void)refreshCityButton:(CityModel *)model
{
    NSString *str = model.name;
    if (model.name.length > 4) {
        str = [model.name substringToIndex:4];
        str = [NSString stringWithFormat:@"%@...",str];
    }
    
    CGSize size = [JSFactory getSize:str maxSize:(CGSizeMake(CGFLOAT_MAX, Anno750(80))) font:[UIFont systemFontOfSize:Anno750(28)]];
    self.cell_width = size.width + Anno750(62);
    [self.cityButton setTitle:str forState:(UIControlStateNormal)];
    [self.cityButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(10)));
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        if (self.cell_width > 0) {
            make.width.equalTo(@(self.cell_width));
        }
        else
        {
            make.width.equalTo(@(Anno750(100)));
        }
    }];
    [self setNeedsLayout];
    [self layoutIfNeeded];

}


@end
