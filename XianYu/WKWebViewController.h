//
//  WKWebViewController.h
//  XinBianLi
//
//  Created by lmh on 2017/11/5.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>




@interface WKWebViewController : BaseViewController

@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) UIColor *navColor;

@property (nonatomic, copy) NSString *baseStr;

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, copy) NSString *myTitle;

@property (nonatomic, assign) WKWebViewNavColorFromType navColorType;

@property (nonatomic, assign) BOOL isBase;

@property (nonatomic, assign) BOOL isB;

- (instancetype)initWithUrl:(NSURL *)url;

- (instancetype)initWithUrl:(NSURL *)url withBaseStr:(NSString *)baseStr withIsTitle:(BOOL)isTitle titleStr:(NSString *)titleStr withNavColorType:(WKWebViewNavColorFromType)colorType;




@end
