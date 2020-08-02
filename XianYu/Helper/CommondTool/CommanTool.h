//
//  CommanTool.h
//  XinBianLi
//
//  Created by lmh on 2017/10/25.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FLAnimatedImage.h>
#import "CustomLoadView.h"
#import "CustomErrorView.h"
#import "CustomNoDataView.h"

@interface CommanTool : NSObject

+ (void)addError:(NSString *)error inView:(UIView *)view;

+ (void)addNoDataView:(UIView *)view withImage:(NSString *)imageStr contentStr:(NSString *)contentStr;

+ (void)addLoadView:(UIView *)view;

+ (void)removeViewType:(NSInteger)type parentView:(UIView *)myView;

@end
