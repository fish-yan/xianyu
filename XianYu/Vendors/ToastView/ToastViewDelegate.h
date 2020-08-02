//
//  ToastViewDelegate.h
//  jianshebao
//
//  Created by 吴孔锐 on 16/8/16.
//  Copyright © 2016年 lmh. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol ToastDelegate <NSObject>

/**
 * 得到当前toast显示文本
 *
 * @param text:当前toast展示的文本
 *
 */
- (void)queryToastText:(NSString*)text;

/**
 * toast显示时调用此方法
 */
- (void)toastAppear;

/**
 * toast消失时调用此方法
 */
- (void)toastDissAppear;
@end
