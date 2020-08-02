
//
//  C_FullJobHeaderView.m
//  XianYu
//
//  Created by lmh on 2019/7/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJobHeaderView.h"
#import "C_JobInfoViewController.h"
#import "C_PartJobInfoViewController.h"

@implementation C_FullJobHeaderView

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
        self.backgroundColor = Color_Ground_F5F5F5;
    }
    return self;
}

- (void)createUI
{
    self.bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    self.bannerView.pageDotColor = Color_White;
    self.bannerView.currentPageDotColor = Color_Gray_828282;
    self.bannerView.backgroundColor = Color_Ground_F5F5F5;
    self.backView = [JSFactory creatViewWithColor:Color_Blue_32A060];
    [JSFactory configureWithView:self.bannerView cornerRadius:Anno750(6) isBorder:NO borderWidth:0 borderColor:nil];
    self.bannerView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.bannerView.autoScrollTimeInterval = 4.0f;
    
    self.searchView = [[C_FullJobSearchView alloc]initWithFrame:(CGRectZero)];
    [JSFactory configureWithView:self.searchView cornerRadius:Anno750(6) isBorder:NO borderWidth:0 borderColor:nil];
    self.jobSelectView = [[C_FullJobSelectButtonView alloc]initWithFrame:(CGRectZero)];
    
    self.areaButton = [JSFactory creatButtonWithTitle:@"全部区域" textFont:font750(26) titleColor:Color_Gray_828282 backGroundColor:Color_White];
    [self.areaButton setImage:GetImage(@"icon_c_fulljob_down") forState:(UIControlStateNormal)];
    [self.areaButton setImage:GetImage(@"icon_c_fulljob_up") forState:(UIControlStateSelected)];
    
    self.distanceButton = [JSFactory creatButtonWithTitle:@"薪资不限" textFont:font750(26) titleColor:Color_Gray_828282 backGroundColor:Color_White];
    [self.distanceButton setImage:GetImage(@"icon_c_fulljob_down") forState:(UIControlStateNormal)];
    [self.distanceButton setImage:GetImage(@"icon_c_fulljob_up") forState:(UIControlStateSelected)];
    self.releaseButton = [JSFactory creatButtonWithTitle:@"推荐排序" textFont:font750(26) titleColor:Color_Gray_828282 backGroundColor:Color_White];
    [self.releaseButton setImage:GetImage(@"icon_c_fulljob_down") forState:(UIControlStateNormal)];
    [self.releaseButton setImage:GetImage(@"icon_c_fulljob_up") forState:(UIControlStateSelected)];

    self.lineView = [JSFactory createLineView];

    
    
    [self addSubview:self.bannerView];
    [self addSubview:self.backView];
    [self addSubview:self.searchView];
    [self addSubview:self.jobSelectView];
    [self addSubview:self.areaButton];
    [self addSubview:self.releaseButton];
    [self addSubview:self.distanceButton];
    [self addSubview:self.lineView];
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@(0));
        make.height.equalTo(@(274 * KScreenWidth/750.0));
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.equalTo(self.bannerView.mas_bottom).offset(Anno750(53) + Anno750(16));
    }];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(self.bannerView.mas_bottom);
        make.height.equalTo(@(Anno750(106)));
    }];
    [self.jobSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@(Anno750(70)));
        make.top.equalTo(self.searchView.mas_bottom).offset(Anno750(16));
    }];
    [self.areaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(@0);
        make.width.equalTo(@(KScreenWidth/3.0));
        make.top.equalTo(self.jobSelectView.mas_bottom);
    }];
    [self.releaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(KScreenWidth/3.0));
        make.top.equalTo(self.areaButton);
        make.right.bottom.equalTo(@0);
    }];
    [self.distanceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.areaButton);
        make.left.equalTo(self.areaButton.mas_right);
        make.right.equalTo(self.releaseButton.mas_left);
        make.bottom.equalTo(@0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
    [self layoutBtns];
 
}

- (void)layoutBtns {
    [self.areaButton layoutButtonWithImageStyle:(ZJButtonImageStyleRight) imageTitleToSpace:Anno750(6)];
    [self.distanceButton layoutButtonWithImageStyle:(ZJButtonImageStyleRight) imageTitleToSpace:Anno750(6)];
    [self.releaseButton layoutButtonWithImageStyle:(ZJButtonImageStyleRight) imageTitleToSpace:Anno750(6)];
}


- (void)loadHeadData
{
//    [self.jobSelectView createJobItemViewWithArray:@[@"全部"]];
    if ([UserManager share].currentFullJobCityModel == nil) {
        [UserManager share].currentFullJobCityModel = [UserManager share].currentCityModel;
    }
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    C_BannerModel *model = self.bannerArray[index];
    
    [self jumpViewControllerModel:model];
}

- (void)jumpViewControllerModel:(C_BannerModel *)model
{
    if (model.type == 0) {
        C_JobInfoViewController *VC = [C_JobInfoViewController new];
        VC.jobId = model.jobid;
        VC.cityModel = [UserManager share].currentCityModel;
        VC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:VC animated:YES];
    }
    else if (model.type == 1)
    {
        C_PartJobInfoViewController *VC = [C_PartJobInfoViewController new];
        VC.jobID = model.jobid;
        VC.cityModel = [UserManager share].currentCityModel;
        VC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:VC animated:YES];
    }
    else if (model.type == 2)
    {
        WKWebViewController *webVC = [[WKWebViewController alloc]initWithUrl:[NSURL URLWithString:model.connecturl] withBaseStr:nil withIsTitle:YES titleStr:nil withNavColorType:(WKWebViewNavColorFromType_White)];
        webVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:webVC animated:YES];
    }
}


//刷新区域
- (void)refreshArearButtonWithModel:(AreaModel *)model
{
    if (model == nil) {
        [self.areaButton setTitle:@"全部区域" forState:(UIControlStateNormal)];
    }
    else
    {
        [self.areaButton setTitle:model.shortname forState:(UIControlStateNormal)];
    }
}

@end
