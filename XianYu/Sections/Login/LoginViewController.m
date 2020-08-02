//
//  LoginViewController.m
//  XianYu
//
//  Created by lmh on 2019/6/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginPrintView.h"
#import "TTTAttributedLabel.h"
#import "BaseFuncViewController.h"
#import "C_RootViewController.h"
#import "BJobPriceViewController.h"

@interface LoginViewController ()<TTTAttributedLabelDelegate>

@property (nonatomic, strong) LoginPrintView *nameView;

@property (nonatomic, strong) LoginPrintView *codeView;

@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIButton *agreeBtn;

@property (nonatomic, strong) TTTAttributedLabel *tLabel;

@property (nonatomic, strong) NSTimer *myTimer;

@property (nonatomic, assign) NSInteger currentInteger;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
}

- (void)createUI
{
    UILabel *nameLabel = [JSFactory creatLabelWithTitle:@"登录/注册" textColor:Color_Black_323232 textFont:font750(58) textAlignment:(NSTextAlignmentLeft)];
    
    self.nameView = [[LoginPrintView alloc]initWithFrame:(CGRectZero)];
    self.nameView.printField.placeholder = @"请输入手机号码";
    self.nameView.printField.keyboardType = UIKeyboardTypeNumberPad;
    self.nameView.printField.tag = 10001;
    self.codeView = [[LoginPrintView alloc]initWithFrame:(CGRectZero)];
    self.codeView.printField.placeholder = @"请输入验证码";
    self.codeView.printField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeView.printField.tag = 10001;
    [self.nameView.printField addTarget:self action:@selector(clickChangeValue:) forControlEvents:(UIControlEventEditingChanged)];
    [self.codeView.printField addTarget:self action:@selector(clickChangeValue:) forControlEvents:(UIControlEventEditingChanged)];
    
    
    
    self.sendButton = [JSFactory creatButtonWithTitle:@"获取验证码" textFont:font750(26) titleColor:Color_Blue_32A060 backGroundColor:Color_White];
    [[self.sendButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self getVerifyCode];
    }];
    [JSFactory configureWithView:self.sendButton cornerRadius:Anno750(6) isBorder:YES borderWidth:0.5 borderColor:Color_Blue_32A060];
    
    
    self.loginButton = [JSFactory creatButtonWithTitle:@"登录" textFont:font750(36) titleColor:Color_White backGroundColor:Color_Blue_32A060];
    [JSFactory configureWithView:self.loginButton cornerRadius:Anno750(6) isBorder:NO borderWidth:0 borderColor:nil];
    [[self.loginButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self sendLogonButton];
    }];
    
    self.agreeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.agreeBtn setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    [self.agreeBtn setImage:[UIImage imageNamed:@"icon_c_fulljob_city_select"] forState:(UIControlStateSelected)];
    self.agreeBtn.layer.borderWidth = 1;
    self.agreeBtn.layer.borderColor = Color_Blue_32A060.CGColor;
    [[self.agreeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        x.selected = !x.selected;
    }];
    
    TTTAttributedLabel *tLable  = [[TTTAttributedLabel alloc]initWithFrame:(CGRectZero)];
    tLable.font = [UIFont systemFontOfSize:font750(26)];
    tLable.textColor = Color_Black_A5A5A5;
    //    tLable.highlightedShadowColor = [UIColor redColor];
    tLable.lineBreakMode = NSLineBreakByWordWrapping;
    tLable.numberOfLines = 0;
    tLable.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    tLable.delegate = self;
    tLable.text = @"登录注册表示同意《咸鱼直聘用户协议》";
    NSRange range = [tLable.text rangeOfString:@"《咸鱼直聘用户协议》"];
    [tLable addLinkToURL:[NSURL URLWithString:@"http://github.com/mattt/"] withRange:range];
    
    
    [self.view addSubview:nameLabel];
    [self.view addSubview:self.nameView];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.sendButton];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.agreeBtn];
    [self.view addSubview:tLable];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(75)));
        make.top.equalTo(@(Anno750(162)));
        make.right.equalTo(@(-Anno750(75)));
        make.height.equalTo(@(Anno750(81)));
    }];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(75)));
        make.right.equalTo(@(-Anno750(75)));
        make.top.equalTo(nameLabel.mas_bottom).offset(Anno750(46));
        make.height.equalTo(@(Anno750(88)));
    }];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(75)));
        make.right.equalTo(@(-Anno750(75)));
        make.top.equalTo(self.nameView.mas_bottom).offset(Anno750(44));
        make.height.equalTo(@(Anno750(88)));
    }];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.codeView);
        make.centerY.equalTo(self.codeView);
        make.size.mas_equalTo(CGSizeMake(Anno750(170), Anno750(60)));
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(75)));
        make.right.equalTo(@(-Anno750(75)));
        make.top.equalTo(self.codeView.mas_bottom).offset(Anno750(100));
        make.height.equalTo(@(Anno750(110)));
    }];
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(75)));
        make.centerY.equalTo(tLable.mas_centerY);
        make.width.height.equalTo(@(Anno750(30)));
    }];
    [tLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.agreeBtn.mas_right).offset(Anno750(6));
        make.top.equalTo(self.loginButton.mas_bottom);
        make.height.equalTo(@(Anno750(73)));
        make.right.equalTo(@(-Anno750(75)));
    }];
    
}


- (void)clickChangeValue:(UITextField *)field
{
    if (field.tag == 10001) {
        if (field.text.length > 11) {
            self.nameView.printField.text = [field.text substringToIndex:11];
        }
    }
    else if (field.tag == 10002)
    {
        if (field.text.length > 4) {
            self.codeView.printField.text = [field.text substringToIndex:4];
        }
    }
}

//label链接
- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url{
    WKWebViewController *webVC = [[WKWebViewController alloc]initWithUrl:nil withBaseStr:@"user.html" withIsTitle:YES titleStr:@"注册协议" withNavColorType:(WKWebViewNavColorFromType_Yellow)];
    [self createViewWithController:webVC andNavType:YES andLoginType:YES];
}

- (void)getVerifyCode
{
    if (self.nameView.printField.text.length == 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请输入手机号码!" duration:1.0f];
        return;
    }
    if (self.nameView.printField.text.length != 11) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"您输入的手机号码有误!" duration:1.0f];
        return;
    }
    self.sendButton.enabled = NO;
    self.currentInteger = 60;
    NSDictionary *params = @{
                             @"mobile":self.nameView.printField.text,
                             @"smstype":@"15"
                             };
    [SVProgressHUD showWithStatus:nil];
    [[NetworkManager instance] sendReq:params pageUrl:XY_GetVerifyCode urlVersion:nil endLoad:NO viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"验证码发送成功!" duration:1.0f];
            self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(runTimer) userInfo:self repeats:YES];
            [self.nameView.printField resignFirstResponder];
            [self.codeView.printField becomeFirstResponder];
        }
        else
        {
            self.sendButton.enabled = YES;
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
        [SVProgressHUD dismiss];
    } errorBlock:^(id error) {
        self.sendButton.enabled = YES;
    }];

}

- (void)runTimer
{
    self.currentInteger--;
    if (self.currentInteger <= 1) {
        [self.myTimer invalidate];
        self.myTimer = nil;
        self.sendButton.enabled = YES;
        [self.sendButton setTitle:@"重新发送" forState:(UIControlStateNormal)];
    }
    else
    {
        [self.sendButton setTitle:[NSString stringWithFormat:@"%lds",self.currentInteger] forState:(UIControlStateNormal)];
    }
}


- (void)sendLogonButton
{
//    // TODO: 临时修改
//    BaseFuncViewController *VC = [BaseFuncViewController new];
//    [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:VC];
//    return;
    if (self.nameView.printField.text.length == 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请输入手机号码!" duration:1.0f];
        return;
    }
    if (self.nameView.printField.text.length != 11) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"您输入的手机号码有误!" duration:1.0f];
        return;
    }
    if (self.codeView.printField.text.length == 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请输入验证码" duration:1.0f];
        return;
    }
    if (self.codeView.printField.text.length != 4) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请输入验证码" duration:1.0f];
        return;
    }
    if (!self.agreeBtn.selected) {
        [ToastView show:@"请同意并勾选用户协议"];
        return;
    }
    
    NSDictionary *params = @{
                             @"mobile":self.nameView.printField.text,
                             @"verifycode":self.codeView.printField.text
                             };
    [SVProgressHUD showWithStatus:nil];
    [[NetworkManager instance] sendReq:params pageUrl:XY_Login urlVersion:nil endLoad:NO viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        [SVProgressHUD dismiss];
        if (successCode == 0) {
            NSDictionary *dict = [result[@"data"] firstObject];
            [UserManager share].token = dict[@"token"];
            [self requestLoginclient];
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
        
    } errorBlock:^(id error) {
        [SVProgressHUD dismiss];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)requestLoginclient {
    
    [NetworkManager sendReq:nil pageUrl:XY_loginclient isLoading:NO complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            NSString *loginclient = [NSString stringWithFormat:@"%@", arr.firstObject[@"loginclient"]];
            if ([loginclient isEqualToString:@"1"]) {
                [self pushToC];
            } else if ([loginclient isEqualToString:@"0"]) {
                [self pushToB];
            } else {
                UIApplication.sharedApplication.keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[BaseFuncViewController new]];
            }
        } else {
            UIApplication.sharedApplication.keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[BaseFuncViewController new]];
        }
    } failure:^(NSInteger code, NSString *msg) {
        UIApplication.sharedApplication.keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[BaseFuncViewController new]];
    }];
    
}

- (void)pushToC {
    [UserManager.share loadUserInfoData:XYC block:^(int code) {
        if (code == 0) {
            [UserManager.share switchClient:XYC complete:^{
                UIApplication.sharedApplication.keyWindow.rootViewController = [C_RootViewController new];
            }];
        } else {
            UIApplication.sharedApplication.keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[BaseFuncViewController new]];
        }
    } withConnect:YES];
    
}

- (void)pushToB {
    [UserManager.share loadUserInfoData:XYB block:^(int code) {
        if (code == 0) {
            if ([[UserManager share].infoModel.havepay isEqualToString:@"1"]) {
                [UserManager.share switchClient:XYB complete:^{
                    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
                    UIApplication.sharedApplication.keyWindow.rootViewController = vc;
                }];
            } else { // 去支付
                BJobPriceViewController *vc = [[UIStoryboard storyboardWithName:@"BJob" bundle:nil] instantiateViewControllerWithIdentifier:@"BJobPriceViewController"];
                vc.isFirst = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } else {
            UIApplication.sharedApplication.keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[BaseFuncViewController new]];
        }
    } withConnect:YES];
}


@end
