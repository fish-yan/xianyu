//
//  UIViewController+Extension.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "BRInfoViewController.h"
#import "C_Regist_EditUserInfoViewController.h"
#import "C_RootViewController.h"

@implementation UIApplication (Extension)

- (UIResponder *)nextResponder {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController swizzled];
    });
    return [super nextResponder];
}

@end

@implementation UIViewController (Extension)

+ (void)swizzled {
    Method originMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method newMethod = class_getInstanceMethod(self, @selector(fy_viewDidLoad));
    method_exchangeImplementations(originMethod, newMethod);
}

- (void)fy_viewDidLoad {
    if ([NSBundle bundleForClass:[self class]] == [NSBundle mainBundle]) {
        if (self.navigationController.viewControllers.count > 1) {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_nav_back_black"] style:(UIBarButtonItemStylePlain) target:self.navigationController action:@selector(popViewControllerAnimated:)];
        }
        self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x464646);
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:font750(36)], NSForegroundColorAttributeName:Color_Black_323232}];
    }
    [self fy_viewDidLoad];
}

//获取当前活动的控制器
+ (UIViewController *)visibleViewController {
    return [self getVisibleViewControllerFrom:[UIApplication sharedApplication].keyWindow.rootViewController] ;
}

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc {
    NSLog(@"%@", vc);
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[(UINavigationController *)vc visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getVisibleViewControllerFrom:[(UITabBarController *)vc selectedViewController]];
    } else {
        if (vc.presentedViewController != nil) {
            return [self getVisibleViewControllerFrom:vc];
        } else {
            return vc;
        }
    }
}


@end
