//
//  BaseViewController.h
//  XianYu
//
//  Created by lmh on 2019/6/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) BOOL isShowLoad;

- (void)setNavTitle:(NSString *)title titleColor:(UIColor *)titleColor andNavColor:(UIColor *)navColor;

- (void)drawBackButtonWithBlackStatus:(NavigationBackType)rec;

- (void)goBack;

- (void)createViewWithController:(UIViewController *)VC andNavType:(BOOL)navType andLoginType:(BOOL)loginType;

- (void)createNavRightItem:(NSString *)itemStr withStrColor:(UIColor *)strColor itemImageStr:(NSString *)imageStr withIsEnable:(BOOL)isEnable;

- (void)clickOneRightNavBarItem;


- (void)createFresh:(UITableView *)myTableView;

- (void)clickRefreshfooter;

- (void)clickRefreshHeader;

@end

NS_ASSUME_NONNULL_END
