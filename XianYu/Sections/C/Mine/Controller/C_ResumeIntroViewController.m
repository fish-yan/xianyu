//
//  C_ResumeIntroViewController.m
//  XianYu
//
//  Created by lmh on 2019/7/24.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_ResumeIntroViewController.h"

@interface C_ResumeIntroViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation C_ResumeIntroViewController

- (RACSubject *)saveSubject
{
    if (!_saveSubject) {
        self.saveSubject = [RACSubject subject];
    }
    return _saveSubject;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButtonWithBlackStatus:(NavigationBackType_Black)];
    [self setNavTitle:@"自我介绍" titleColor:Color_Black_464646 andNavColor:Color_White];
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    UIView *backView = [JSFactory creatViewWithColor:Color_White];
    [JSFactory configureWithView:backView cornerRadius:Anno750(6) isBorder:YES borderWidth:0.5 borderColor:Color_Black_A5A5A5];
    self.textView = [[UITextView alloc]initWithFrame:(CGRectZero)];
    self.textView.font = [UIFont systemFontOfSize:font750(26)];
    self.textView.text = @"请简单介绍下自己";
    self.textView.textColor = Color_Black_A5A5A5;
    
    self.textView.delegate = self;
    
    if (self.selfdes.length == 0) {
        self.textView.text = @"请简单介绍下自己";
    }
    else
    {
        self.textView.text = self.selfdes;
    }
    
    self.numLabel = [JSFactory creatLabelWithTitle:@"0/500" textColor:Color_Blue_32A060 textFont:font750(24) textAlignment:(NSTextAlignmentRight)];
    UIButton *sureButton = [JSFactory creatButtonWithTitle:@"完成" textFont:font750(36) titleColor:Color_White backGroundColor:Color_Blue_32A060];
    [JSFactory configureWithView:sureButton cornerRadius:Anno750(6) isBorder:NO borderWidth:0 borderColor:nil];
    [[sureButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self loadResumeData];
    }];
    [self.view addSubview:backView];
    [backView addSubview:self.textView];
    [self.view addSubview:self.numLabel];
    [self.view addSubview:sureButton];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(@(Anno750(40) + NavRectHeight));
        make.right.equalTo(@(-Anno750(24)));
        make.height.equalTo(@(Anno750(360)));
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(Anno750(20));
        make.right.equalTo(backView).offset(-Anno750(20));
        make.top.equalTo(backView).offset(Anno750(20));
        make.bottom.equalTo(backView).offset(-Anno750(20));
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView);
        make.top.equalTo(backView.mas_bottom).offset(Anno750(10));
        make.height.equalTo(@(Anno750(40)));
    }];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(75)));
        make.right.equalTo(@(-Anno750(75)));
        make.height.equalTo(@(Anno750(110)));
        make.top.equalTo(backView.mas_bottom).offset(Anno750(300));
    }];
}

- (void)loadResumeData
{
    if (self.textView.text.length == 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请输入自我介绍" duration:1.0f];
        return;
    }
    NSDictionary *params = @{
                             @"selfdes":self.textView.text
                             };
    [SVProgressHUD showWithStatus:nil];
    [[NetworkManager instance] sendReq:params pageUrl:XY_C_SaveResumeInfoData urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            [super goBack];
            if (self.saveSubject) {
                [self.saveSubject sendNext:self.textView.text];
            }
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
        [SVProgressHUD dismiss];
    } errorBlock:^(id error) {
        
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请简单介绍下自己"]) {
        textView.text = @"";
        textView.textColor = Color_Black_464646;
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    
    return YES;
    
}

/**
 结束编辑
 
 @param textView textView
 */
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length <1) {
        textView.text = @"请简单介绍下自己";
        textView.textColor = Color_Black_A5A5A5;
    }
    
    
}




- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请简单介绍下自己"]) {
        textView.textColor = Color_Black_A5A5A5;
    }
    else
    {
        textView.textColor = Color_Black_464646;
    }
    if (textView.text.length > 300) {
        textView.text = [textView.text substringToIndex:300];
        self.numLabel.text = [NSString stringWithFormat:@"%lu/300", textView.text.length  ];
        
    }
    else
    {
        self.numLabel.text = [NSString stringWithFormat:@"%lu/300", textView.text.length  ];

    }
    self.selfdes = textView.text;
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
