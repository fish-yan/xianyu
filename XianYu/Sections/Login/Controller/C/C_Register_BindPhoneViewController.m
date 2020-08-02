//
//  C_Register_BindPhoneViewController.m
//  XianYu
//
//  Created by lmh on 2019/6/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Register_BindPhoneViewController.h"
#import "LoginPrintView.h"

@interface C_Register_BindPhoneViewController ()

@property (nonatomic, strong) LoginPrintView *phoneView;

@property (nonatomic, strong) LoginPrintView *codeView;

@property (nonatomic, strong) UIButton *sendButton;

@end

@implementation C_Register_BindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"绑定手机号" titleColor:Color_Black_323232 andNavColor:Color_White];
    [self drawBackButtonWithBlackStatus:(NavigationBackType_Black)];
    [self createUI];
}

- (void)createUI{
    self.phoneView = [[LoginPrintView alloc]initWithFrame:(CGRectZero)];
    self.codeView = [[LoginPrintView alloc]initWithFrame:(CGRectZero)];
    self.sendButton = [JSFactory creatButtonWithTitle:@"获取验证码" textFont:font750(26) titleColor:Color_Blue_32A060 backGroundColor:Color_White];
    [JSFactory configureWithView:self.sendButton cornerRadius:Anno750(6) isBorder:YES borderWidth:0.5 borderColor:Color_Blue_32A060];
    [[self.sendButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    
    
    UIButton *sureButton = [JSFactory creatButtonWithTitle:@"确定" textFont:font750(36) titleColor:Color_White backGroundColor:Color_Blue_32A060];
    [JSFactory configureWithView:sureButton cornerRadius:Anno750(6) isBorder:NO borderWidth:0 borderColor:nil];
    [[sureButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    
    
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.sendButton];
    [self.view addSubview:sureButton];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(Anno750(110)));
    }];
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.phoneView.mas_bottom);
        make.height.equalTo(@(Anno750(110)));
    }];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(self.codeView);
        make.size.mas_equalTo(CGSizeMake(Anno750(170), Anno750(60)));
    }];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(75)));
        make.right.equalTo(@(-Anno750(75)));
        make.height.equalTo(@(Anno750(110)));
        make.top.equalTo(self.codeView.mas_bottom).offset(Anno750(319));
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

@end
