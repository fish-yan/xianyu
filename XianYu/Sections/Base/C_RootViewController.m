//
//  C_RootViewController.m
//  XianYu
//
//  Created by lmh on 2019/6/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_RootViewController.h"
#import "C_FullJobViewController.h"
#import "C_PartJobViewController.h"
#import "C_NewsViewController.h"
#import "C_MineViewController.h"

@interface C_RootViewController ()

@end

@implementation C_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabbarItems];
    self.view.backgroundColor = Color_White;
    UIView *view = [JSFactory creatViewWithColor:Color_White];
    view.frame = self.tabBar.bounds;
    [[UITabBar appearance] insertSubview:view atIndex:0];
//    //    self.tabBar.translucent = NO;
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[@"NSForegroundColorAttributeName"] = Color_Gray_878787;
//    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
//    selectTextAttrs[@"NSForegroundColorAttributeName"] = Color_Black_464646;
//    [self.tabBarItem setTitleTextAttributes:textAttrs forState:(UIControlStateNormal)];
//    [self.tabBarItem setTitleTextAttributes:selectTextAttrs forState:(UIControlStateSelected)];
    [[UITabBarItem appearance] setTitleTextAttributes:                                                         [NSDictionary dictionaryWithObjectsAndKeys:Color_Black_A5A5A5,NSForegroundColorAttributeName, nil]forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:                                                         [NSDictionary dictionaryWithObjectsAndKeys:Color_Blue_32A060,NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
//    // Do any additional setup after loading the view.
    [[UITabBar appearance] setBarTintColor:Color_White];
}

- (void)createTabbarItems{
    C_FullJobViewController *fullVC = [C_FullJobViewController new];
    fullVC.title = @"全职";
    UINavigationController *fullNVC = [[UINavigationController alloc]initWithRootViewController:fullVC];
    fullNVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_tabbar_fulljob_select"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    fullNVC.tabBarItem.image = [[UIImage imageNamed:@"icon_tabbar_fulljob"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    
    C_PartJobViewController *partVC = [[C_PartJobViewController alloc]init];
    partVC.title = @"兼职";
    UINavigationController *partNVC = [[UINavigationController alloc]initWithRootViewController:partVC];
    partNVC.tabBarItem.image = [[UIImage imageNamed:@"icon_tabbar_partjob"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    partNVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_tabbar_partjob_select"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    
    C_NewsViewController *newsVC = [[C_NewsViewController alloc]init];
    newsVC.title = @"消息";
    UINavigationController *newsNVC = [[UINavigationController alloc]initWithRootViewController:newsVC];
    newsNVC.tabBarItem.image = [[UIImage imageNamed:@"icon_tabba_c_news"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    newsNVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_tabba_c_news_select"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    //    [packetNVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_Red_FE8137} forState:(UIControlStateSelected)];
    
    C_MineViewController *mineVC = [C_MineViewController new];
    mineVC.title = @"我的";
    UINavigationController *mineNVC = [[UINavigationController alloc]initWithRootViewController:mineVC];
    mineNVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_tabba_c_mine_select"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    mineNVC.tabBarItem.image = [[UIImage imageNamed:@"icon_tabba_c_mine"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    self.viewControllers = @[fullNVC, partNVC, newsNVC, mineNVC];
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
