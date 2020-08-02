//
//  BaseViewController.m
//  XianYu
//
//  Created by lmh on 2019/6/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()




@end
@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}


- (BOOL)prefersHomeIndicatorAutoHidden{
    
    return YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    self.view.backgroundColor = Color_White;
    // Do any additional setup after loading the view.
}

- (void)setNavTitle:(NSString *)title titleColor:(UIColor *)titleColor andNavColor:(UIColor *)navColor
{
    UILabel * titleLabel = [JSFactory creatLabelWithTitle:title textColor:titleColor textFont:font750(36) textAlignment:(NSTextAlignmentCenter)];
    titleLabel.frame = CGRectMake(0, 0, 100, 22);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:font750(36)];
    self.navigationItem.titleView = titleLabel;
    [self.navigationController.navigationBar setBarTintColor:navColor];
}
- (void)drawBackButtonWithBlackStatus:(NavigationBackType)rec{
    if (rec == NavigationBackType_Clear) {
        UIImage * image = [[UIImage imageNamed:@"icon_clear"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithImage:image
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:nil];
        self.navigationItem.leftBarButtonItem = back;
    }
    else
    {
        [self createBackButton:rec];
    }
}

- (void)createBackButton:(NavigationBackType)rec{
    
    NSString *imageStr;
    if (rec == NavigationBackType_Black) {
        imageStr = @"icon_nav_back_black";
    }
    else if (rec == NavigationBackType_White)
    {
        imageStr = @"icon_nav_white_new";
    }
    UIImage * image = [[UIImage imageNamed:imageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithImage:image
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = back;
}
//点击导航栏左侧
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)createViewWithController:(UIViewController *)VC andNavType:(BOOL)navType andLoginType:(BOOL)loginType
{
    [VC setHidesBottomBarWhenPushed:YES];
//    VC.navigationController.fd_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)createNavRightItem:(NSString *)itemStr withStrColor:(UIColor *)strColor itemImageStr:(NSString *)imageStr withIsEnable:(BOOL)isEnable
{
    if (itemStr.length > 0) {
        UIBarButtonItem *items =[[UIBarButtonItem alloc]initWithTitle:itemStr style:(UIBarButtonItemStyleDone) target:self action:@selector(clickOneRightNavBarItem)];
        items.tintColor = strColor;
        items.enabled = isEnable;
        self.navigationItem.rightBarButtonItem = items;
    }
    else
    {
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:imageStr] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStyleDone) target:self action:@selector(clickOneRightNavBarItem)];
        barItem.enabled = isEnable;
        self.navigationItem.rightBarButtonItem = barItem;
    }
    
}
- (void)clickOneRightNavBarItem
{
    
}


- (void)createFresh:(UITableView *)myTableView
{
    
    MJRefreshBackNormalFooter *footerRefresh = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(clickRefreshfooter)];
    footerRefresh.stateLabel.textColor = RGBColor(165, 165, 165);
    [footerRefresh setTitle:@"我是有底线的" forState:(MJRefreshStateNoMoreData)];
    myTableView.mj_footer = footerRefresh;
    MJRefreshNormalHeader *headerRefresh = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(clickRefreshHeader)];
    headerRefresh.stateLabel.textColor = RGBColor(165, 165, 165);
    headerRefresh.lastUpdatedTimeLabel.textColor = RGBColor(165, 165, 165);
    //    headerRefresh.ignoredScrollViewContentInsetTop = Anno750(100);
    myTableView.mj_header = headerRefresh;
}

- (void)createFreshFooter:(UITableView *)myTableView
{
    MJRefreshBackNormalFooter *footerRefresh = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(clickRefreshfooter)];
    footerRefresh.stateLabel.textColor = RGBColor(165, 165, 165);
    [footerRefresh setTitle:@"我是有底线的" forState:(MJRefreshStateNoMoreData)];
    myTableView.mj_footer = footerRefresh;
}

- (void)clickRefreshfooter
{
    
}

- (void)clickRefreshHeader
{
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
