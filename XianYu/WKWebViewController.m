//
//  WKWebViewController.m
//  XinBianLi
//
//  Created by lmh on 2017/11/5.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import "WKWebViewController.h"


@interface WKWebViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, assign) BOOL isTitle;

@property (nonatomic, copy) NSString *titleStr;

@end

@implementation WKWebViewController

- (instancetype)initWithUrl:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.url = url;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (instancetype)initWithUrl:(NSURL *)url withBaseStr:(NSString *)baseStr withIsTitle:(BOOL)isTitle titleStr:(NSString *)titleStr withNavColorType:(WKWebViewNavColorFromType)colorType
{
    if (self = [super init]) {
        self.baseStr = baseStr;
        if (self.baseStr.length > 0) {
            self.navColor = Color_White;
        }
        else
        {
            self.navColor = Color_White;
        }
        self.navColorType = colorType;
        self.url = url;
        self.isTitle = isTitle;
        self.titleStr = titleStr;
//        [self viewDidLoad];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self drawLeftBarButton];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault)];
    self.navigationController.navigationBarHidden = NO;
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:NULL];
        [self.webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial  context:NULL];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:NULL];
    
    if (self.isTitle) {
        [self setNavTitle:self.titleStr titleColor:Color_Black_464646 andNavColor:self.navColor];
        self.myTitle = self.titleStr;
        
    }
    else
    {
        [self setNavTitle:self.titleStr titleColor:Color_Black_464646 andNavColor:self.navColor];
    }
    
    if (self.navColorType == WKWebViewNavColorFromType_White) {
        
    }
    else if (self.navColorType == WKWebViewNavColorFromType_Yellow)
    {
        
    }
    else if (self.navColorType == WKWebViewNavColorFromType_Clear)
    {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:(UIBarMetricsDefault)];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
//        self.navigationController.navigationBar.translucent = YES;
    }
    else if (self.navColorType == WKWebViewNavColorFromType_Red)
    {
        [self setNavTitle:@"" titleColor:Color_Black_464646 andNavColor:Color_White];
        [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent)];
    }
    
   
    if (self.navColorType == WKWebViewNavColorFromType_Clear || self.navColorType == WKWebViewNavColorFromType_Red) {
        [self drawBackButtonWithBlackStatus:NavigationBackType_White];
    }
    else
    {
        [self drawBackButtonWithBlackStatus:NavigationBackType_Black];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIView *view = [self.navigationController.view viewWithTag:60001];
    [view removeFromSuperview];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:(UIBarMetricsDefault)];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent)];
    [self addObserverNotification];
    
    self.view.backgroundColor = Color_Ground_F5F5F5;
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    WKUserContentController *controller = [[WKUserContentController alloc]init];

    configuration.userContentController = controller;
    CGFloat web_h = KScreenHeight -AppStatusBar - 44;
    CGFloat web_y = 0;
    if (self.navColorType == WKWebViewNavColorFromType_Clear) {
        web_h = KScreenHeight + NavRectHeight;
        web_y = -NavRectHeight;
    }
    self.webView = [[WKWebView alloc]initWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight)) configuration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.scrollView.bounces = NO;
    if (self.baseStr.length > 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:self.baseStr ofType:nil];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    }
    else
    {
        [self.webView loadRequest:request];
    }
    [self.view addSubview:self.webView];
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, Anno750(30))];
    self.progressView.trackTintColor = Color_Line_EBEBEB;
    self.progressView.progressTintColor = UIColorFromRGB(0xFF5F5);
    [self.view addSubview:self.progressView];
    
    
    
}

- (void)refreshResumeNum
{
    [super goBack];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESHHEADHUNTERVIEW" object:self userInfo:nil];
}

- (void)drawLeftBarButton{
    
    self.closeButton = [JSFactory creatButtonWithNormalImage:@"icon_web_close" selectImage:@"icon_web_close"];
    self.closeButton.hidden = YES;
    self.closeButton.tag = 60001;
    [self.closeButton addTarget:self action:@selector(doBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self.navigationController.view addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(80)));
        make.top.equalTo(@(AppStatusBar));
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
}

- (void)goBack{
    
    
//    NSString *jsStr2 = [NSString stringWithFormat:@"getAppData('%@')",@"哈哈哈哈"];
//    [self.webView evaluateJavaScript:jsStr2 completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        NSLog(@"%@----%@",result, error);
//    }];
//    [_webView evaluateJavaScript:jsStr2 completionHandler:^(id result, NSError * _Nullable error) {
//        NSLog(@"%@",result);
//        NSLog(@"%@",error);
//    }];
    NSArray *array = self.webView.backForwardList.backList;
    if ([self.myTitle isEqualToString:@"新手攻略"]) {
        [super goBack];
    }
    else if ([self.myTitle isEqualToString:@"美差攻略"])
    {
        [super goBack];
    }
    else
    {
        if(self.webView.canGoBack){
            [self.webView goBack];
        }else{
            [super goBack];

        }
    }
    
}


- (void)doBack{
    [super goBack];
}

#pragma mark --------
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
//    if (self.buyButton != nil) {
//        [self.buyButton removeFromSuperview];
//    }
   
//    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo
{
    return YES;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
    
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([strRequest containsString:@"tel"]) {
        UIWebView *web = [[UIWebView alloc]init];
        NSString *telString = [strRequest stringByReplacingOccurrencesOfString:@" " withString:@""];
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",telString]]]];
        [self.view addSubview:web];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else
    {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
   

}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(nonnull WKNavigationResponse *)navigationResponse decisionHandler:(nonnull void (^)(WKNavigationResponsePolicy))decisionHandler
{

    decisionHandler(WKNavigationResponsePolicyAllow);
}



- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
}



- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.closeButton removeFromSuperview];
    self.webView.navigationDelegate = nil;
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"URL"];
//    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}





#pragma mark  --通知
-(void)addObserverNotification{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(windowDidBecomeHidden:) name:UIWindowDidBecomeHiddenNotification object:nil];
}

-(void)windowDidBecomeHidden:(NSNotification *)noti{
    
    UIWindow * win = (UIWindow *)noti.object;
    
    if(win){
        
        UIViewController *rootVC = win.rootViewController;
        
        NSArray<__kindof UIViewController *> *vcs = rootVC.childViewControllers;
        
        if([vcs.firstObject isKindOfClass:NSClassFromString(@"AVPlayerViewController")]){
            
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        }
    }
}


- (NSString *)getNavFrameHeight
{
    return @"哈哈哈哈哈";
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
