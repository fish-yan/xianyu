//
//  C_Regist_EditUserInfoViewController.m
//  XianYu
//
//  Created by lmh on 2019/6/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Regist_EditUserInfoViewController.h"
#import "LabelOfLabelCell.h"
#import "XYPickPhotoUtils.h"
#import "XYActionSheetViewController.h"
#import "XYConstUtils.h"
#import "CustomeDatePickerView.h"
#import "C_RootViewController.h"

@interface C_Regist_EditUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource, CustomeDatePickerViewDelagate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, copy) NSString *imageStr;

@property (nonatomic, copy) NSString *sexStr;

@property (nonatomic, copy) NSString *birthStr;

@property (nonatomic, copy) NSString *jobExpStr;

@property (nonatomic, copy) NSString *nameStr;

@property (nonatomic, strong) UITextField *myField;

@end

@implementation C_Regist_EditUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"完善基本信息" titleColor:Color_Black_323232 andNavColor:Color_White];
    [self drawBackButtonWithBlackStatus:(NavigationBackType_Black)];
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight)) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self createTableHeaderView];
    [self createTableFooterView];
}

- (void)createTableHeaderView
{
    UIView *headView = [JSFactory creatViewWithColor:Color_White];
    headView.frame = CGRectMake(0, 0, KScreenWidth, KScreenWidth * 279/750.0);
    self.tableView.tableHeaderView = headView;
    self.headImageView = [JSFactory creatImageViewWithImageName:@""];
    self.headImageView.backgroundColor = Color_Ground_F5F5F5;
    self.headImageView.userInteractionEnabled = YES;
    [JSFactory configureWithView:self.headImageView cornerRadius:Anno750(130)/2.0 isBorder:NO borderWidth:0 borderColor:nil];
    UILabel *topLabel = [JSFactory creatLabelWithTitle:@"设置个人头像" textColor:Color_Black_A5A5A5 textFont:font750(26) textAlignment:(NSTextAlignmentCenter)];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openPhotoView)];
    [self.headImageView addGestureRecognizer:tapGesture];
    [headView addSubview:self.headImageView];
    [headView addSubview:topLabel];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView);
        make.size.mas_equalTo(CGSizeMake(Anno750(130), Anno750(130)));
        make.top.equalTo(@(Anno750(62)));
    }];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(Anno750(14));
        make.centerX.equalTo(headView);
        make.height.equalTo(@(Anno750(37)));
    }];
    
    
}

- (void)createTableFooterView
{
    UIView *footerView = [JSFactory creatViewWithColor:Color_White];
    footerView.frame = CGRectMake(0, 0, KScreenWidth, Anno750(294));
    self.tableView.tableFooterView = footerView;
    UIView *lineView = [JSFactory createLineView];
    
    UIButton *nextButton = [JSFactory creatButtonWithTitle:@"下一步" textFont:font750(36) titleColor:Color_White backGroundColor:Color_Blue_32A060];
    [[nextButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self saveUserData];
    }];
    
    [footerView addSubview:nextButton];
    [footerView addSubview:lineView];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(75)));
        make.right.equalTo(@(-Anno750(75)));
        make.height.equalTo(@(Anno750(110)));
        make.top.equalTo(footerView).offset(Anno750(184));
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier_list = @"listCell";
    LabelOfLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_list];
    if (!cell) {
        cell = [[LabelOfLabelCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_list];
    }
    cell.printField.hidden = YES;
    cell.summaryLabel.hidden = NO;
    cell.arrowImageView.hidden = NO;
    if (indexPath.row == 0) {
        [cell configureWithNameStr:@"姓名" withIsField:YES withPlaceHolder:@"请输入" withSummarStr:self.nameStr];
        cell.arrowImageView.hidden = YES;
        cell.summaryLabel.hidden = YES;
        cell.printField.hidden = NO;
        cell.printField.placeholder = @"请填写";
        self.myField = cell.printField;
    }
    else if (indexPath.row == 1)
    {
        [cell configureWithNameStr:@"性别" withIsField:NO withPlaceHolder:@"" withSummarStr:@"请选择"];
        if (self.sexStr.length > 0) {
            cell.summaryLabel.text = self.sexStr;
            cell.summaryLabel.textColor = Color_Gray_828282;
        }
        else
        {
            cell.summaryLabel.text = @"请选择";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
        
    }
    else if (indexPath.row == 2)
    {
        [cell configureWithNameStr:@"出生年月" withIsField:NO withPlaceHolder:@"" withSummarStr:@"请选择"];
        if (self.birthStr.length > 0) {
            cell.summaryLabel.text = self.birthStr;
            cell.summaryLabel.textColor = Color_Gray_828282;
        }
        else
        {
            cell.summaryLabel.text = @"请选择";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
        
    }
    else
    {
        [cell configureWithNameStr:@"工作经验" withIsField:NO withPlaceHolder:@"" withSummarStr:@"请选择"];
        if (self.jobExpStr.length > 0) {
            cell.summaryLabel.text = self.jobExpStr;
            cell.summaryLabel.textColor = Color_Gray_828282;
        }
        else
        {
            cell.summaryLabel.text = @"请选择";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //性别
    if (indexPath.row == 1)
    {
        [self selectSex];
    }
    //出生年月
    else if (indexPath.row == 2)
    {
        [self selectBirth];
    }
    //工作经验
    else if (indexPath.row == 3)
    {
        [self selectJobYear];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Anno750(110);
}

#pragma mark -------- 性别 -----------

- (void)selectSex
{
    XYActionSheetViewController *action = [XYActionSheetViewController show: xy_sex complete:^(NSString * _Nonnull title) {
//            self.viewModel.sex.des = title;
        self.sexStr = title;
        [self.tableView reloadData];
    }];
    action.headTitle = @"性别";
}

#pragma mark -------- 出生年月 -----------

- (void)selectBirth
{

    CustomeDatePickerView *datePicker = [[CustomeDatePickerView alloc]initWithFrame:self.navigationController.view.bounds];
    datePicker.delegate = self;
    datePicker.viewController = self;
    [self.navigationController.view addSubview:datePicker];
}

- (void)configureWithDateString:(NSString *)dataString
{
    self.birthStr = dataString;
    [self.tableView reloadData];
}

#pragma mark -------  工作经验 ----------
- (void)selectJobYear
{
    XYActionSheetViewController *action = [XYActionSheetViewController show: xy_exp complete:^(NSString * _Nonnull title) {
                self.jobExpStr = title;
                [self.tableView reloadData];
    }];
    action.headTitle = @"工作经验";
}


- (void)openPhotoView
{
    [XYPickPhotoUtils pickPhoto:self complete:^(UIImage * _Nonnull img) {
        [[OSSManager share] uploadImage:img withSize:(CGSizeMake(400, 400)) withBlock:^(id  _Nonnull result) {
            NSString *imageStr = result;
            self.imageStr = imageStr;
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.imageStr] placeholderImage:nil];
            
        }];
    }];
}

- (void)saveUserData
{
    
    self.nameStr = self.myField.text;
    if (self.imageStr.length == 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请上传头像" duration:1.0f];
        return;
    }
    if (self.nameStr.length == 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请输入您的姓名" duration:1.0f];
        return;
    }
    if (self.sexStr.length == 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请选择性别" duration:1.0f];
        return;
    }
    if (self.birthStr.length == 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请选择出生年月" duration:1.0f];
        return;
    }
    if (self.jobExpStr.length == 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请选择工作经验" duration:1.0f];
        return;
    }
    [SVProgressHUD showWithStatus:nil];
    NSDictionary *params = @{
                             @"photo":self.imageStr,
                             @"name":self.nameStr,
                             @"sex":self.sexStr,
                             @"brith":self.birthStr,
                             @"jobexp":self.jobExpStr,
                             };
    [[NetworkManager instance] sendReq:params pageUrl:XY_C_Register_SaveUserData urlVersion:nil endLoad:NO viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            [UserManager.share loadUserInfoData:XYC block:^(int code) {
                if (code == 0) {
                    [UserManager.share switchClient:XYC complete:^{
                        [UIApplication sharedApplication].keyWindow.rootViewController = [C_RootViewController new];
                    }];
                }
            } withConnect:YES];            
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
        [SVProgressHUD dismiss];
    } errorBlock:^(id error) {
        
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
