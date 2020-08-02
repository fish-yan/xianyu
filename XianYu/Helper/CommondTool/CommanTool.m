//
//  CommanTool.m
//  XinBianLi
//
//  Created by lmh on 2017/10/25.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import "CommanTool.h"
#import <UIImage+GIF.h>
#import <FLAnimatedImage.h>

@implementation CommanTool
static CommanTool *manager = nil;
+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CommanTool alloc]init];
    });
    return manager;
}


- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}



+ (void)createErrorView:(NSString *)errorStr withView:(UIView *)myView
{
    CustomErrorView *errorView = nil;
    if (errorStr.length > 0) {
        errorView = [[CustomErrorView alloc]initWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight)) isError:YES];
    }
    else
    {
        errorView = [[CustomErrorView alloc]initWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight)) isError:NO];
    }
    [errorView.errorButton addTarget:[CommanTool manager] action:@selector(clickErrorButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [myView addSubview:errorView];

}

+ (void)createLoadingView:(UIView *)myView
{
    
    CustomLoadView *loadView = [[CustomLoadView alloc]initWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight))];
    loadView.backgroundColor = Color_White;
    [myView addSubview:loadView];
}

+ (void)createNotDataView:(UIView *)myView withImage:(NSString *)imageStr contentStr:(NSString *)contentStr
{
    CustomNoDataView *noDataView = [[CustomNoDataView alloc]initWithFrame:myView.bounds];
    noDataView.backgroundColor = Color_White;
    noDataView.promptImageView.contentMode = UIViewContentModeScaleAspectFit;
    noDataView.promptImageView.image = [UIImage imageNamed:imageStr];
    noDataView.contentLabel.text = contentStr;
    [myView addSubview:noDataView];
}

+ (void)addError:(NSString *)error inView:(UIView *)myView
{
    NSArray *array = [myView subviews];
    for (UIView *view in array) {
        if ([view isKindOfClass:[CustomErrorView class]]) {
            [view removeFromSuperview];
        }
    }
    [CommanTool createErrorView:error withView:myView];
}

+ (void)addNoDataView:(UIView *)view withImage:(NSString *)imageStr contentStr:(NSString *)contentStr
{
    NSArray *array = [view subviews];
    for (UIView *view in array) {
        if ([view isKindOfClass:[CustomLoadView class]]) {
            [view removeFromSuperview];
        }
    }
    [CATransaction setCompletionBlock:^{
        [CommanTool createNotDataView:view withImage:imageStr contentStr:contentStr];
    }];
}

+ (void)addLoadView:(UIView *)view
{
    NSArray *array = [view subviews];
    for (UIView *view in array) {
        if ([view isKindOfClass:[CustomLoadView class]]) {
            [view removeFromSuperview];
        }
    }
    [CommanTool createLoadingView:view];
}


+ (void)removeViewType:(NSInteger)type parentView:(UIView *)myView
{
    if (type == 1) {
        NSArray *array = [myView subviews];
        for (UIView *view in array) {
            if ([view isKindOfClass:[CustomLoadView class]]) {
                [view removeFromSuperview];
            }
        }
    }
    else if (type == 2)
    {
        NSArray *array = [myView subviews];
        for (UIView *view in array) {
            if ([view  isKindOfClass:[CustomErrorView class]]) {
                [view removeFromSuperview];
            }
        }
   
    }
    else if(type == 3)
    {
        NSArray *array = [myView subviews];
        for (UIView *view in array) {
            if ([view  isKindOfClass:[CustomNoDataView class]]) {
                [view removeFromSuperview];
            }
        }
    }
    else if(type == 4)
    {
        NSArray *array = [myView subviews];
        for (UIView *view in array) {
            if ([view isKindOfClass:[CustomLoadView class]]) {
                [view removeFromSuperview];
            }
            if ([view  isKindOfClass:[CustomErrorView class]]) {
                [view removeFromSuperview];
            }
            if ([view  isKindOfClass:[CustomNoDataView class]]) {
                [view removeFromSuperview];
            }
            
        }
    }
}

- (void)clickErrorButton:(UIButton *)sender
{
    
//    UIView *sendView = [sender superview];
//    BaseViewController *viewController = (BaseViewController *)[JSFactory belongViewController:sendView];
//    [viewController loadAllData];
//    if ([BaseModel isLogin]) {
//        UserInfoModel *model = [UserManager manager].info;
//        if (model.nickName.length == 0) {
//            [[UserManager manager] getUserInfoData:YES];
//        }
//    }
}


@end
