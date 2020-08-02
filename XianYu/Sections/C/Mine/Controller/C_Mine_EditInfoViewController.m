//
//  C_Mine_EditInfoViewController.m
//  XianYu
//
//  Created by lmh on 2019/7/3.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_EditInfoViewController.h"
#import "C_Mine_EditUserInfoListCell.h"
#import "C_Mine_ResumeModel.h"
#import "XYPickPhotoUtils.h"
#import "BRTFViewController.h"
#import "XYConstUtils.h"
#import "XianYu-Swift.h"
#import "C_ResumeIntroViewController.h"
#import "C_Mine_Resume_JobExpModel.h"
#import "C_Mine_EditFooterView.h"

@interface C_Mine_EditInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) C_Mine_ResumeModel *currentModel;

@property (nonatomic, strong) C_Mine_EditFooterView *footerView;

@property (nonatomic, strong) UIImageView *imageView1;

@property (nonatomic, strong) UIImageView *imageView2;

@property (nonatomic, strong) UIImageView *imageView3;

@end

@implementation C_Mine_EditInfoViewController

- (C_Mine_ResumeModel *)currentModel {
    if (!_currentModel) {
        _currentModel = [[C_Mine_ResumeModel alloc]init];
    }
    return _currentModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"完善基本信息" titleColor:Color_Black_464646 andNavColor:Color_White];
    [self drawBackButtonWithBlackStatus:(NavigationBackType_Black)];
    [self createUI];
    [self saveUserInfoData];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight)) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 0.0001f;
    self.tableView.sectionHeaderHeight = 0.0001f;
    [self.view addSubview:self.tableView];
    self.footerView = [[C_Mine_EditFooterView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, Anno750(260))];
    self.tableView.tableFooterView = self.footerView;
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, KScreenWidth, Anno750(260));
    __block typeof(self) weakSelf = self;
    self.footerView.complete = ^(NSString * _Nonnull imgStr, NSInteger tag) {
        if (tag == 0) {
            [weakSelf sevejobphotooneWithStr:imgStr];
        } else if (tag == 1) {
            [weakSelf sevejobphototwoWithStr:imgStr];
        } else if (tag == 2) {
            [weakSelf sevejobphotothreeWithStr:imgStr];
        }
    };

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier_list = @"listCell";
    C_Mine_EditUserInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_list];
    if (!cell) {
        cell = [[C_Mine_EditUserInfoListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_list];
    }
    cell.userImageView.backgroundColor = Color_Ground_F5F5F5;
    cell.summaryLabel.hidden = NO;
    cell.rightImageView.hidden = NO;
    cell.userImageView.hidden = YES;
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"头像";
        cell.summaryLabel.hidden = YES;
        cell.rightImageView.hidden = YES;
        cell.userImageView.hidden = NO;
        if (self.currentModel.photo.length > 0) {
            [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:self.currentModel.photo] placeholderImage:nil];
        }
    }
    else if (indexPath.row == 1)
    {
        cell.nameLabel.text = @"姓名";
        if (self.currentModel.name.length > 0) {
            cell.summaryLabel.text = self.currentModel.name;
            cell.summaryLabel.textColor = Color_Black_323232;
        }
        else
        {
            cell.summaryLabel.text = @"请填写";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
    }
    else if (indexPath.row == 2)
    {
        cell.nameLabel.text = @"性别";
        if (self.currentModel.sex.length > 0) {
            cell.summaryLabel.text = self.currentModel.sex;
            cell.summaryLabel.textColor = Color_Black_323232;
        }
        else
        {
            cell.summaryLabel.text = @"选择";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
    }
    else if (indexPath.row == 3)
    {
        cell.nameLabel.text = @"手机号";
        if (self.currentModel.mobile.length > 0) {
            cell.summaryLabel.text = self.currentModel.mobile;
            cell.summaryLabel.textColor = Color_Black_323232;
        }
        else
        {
            cell.summaryLabel.text = @"请填写";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
    }
    else if (indexPath.row == 4)
    {
        cell.nameLabel.text = @"微信号";
        if (self.currentModel.wechat.length > 0) {
            cell.summaryLabel.text = self.currentModel.wechat;
            cell.summaryLabel.textColor = Color_Black_323232;
        }
        else
        {
            cell.summaryLabel.text = @"请填写";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
    }
    else if (indexPath.row == 5)
    {
        cell.nameLabel.text = @"学历";
        if (self.currentModel.educationname.length > 0) {
            cell.summaryLabel.text = self.currentModel.educationname;
            cell.summaryLabel.textColor = Color_Black_323232;
        }
        else
        {
            cell.summaryLabel.text = @"请选择";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
    }
    else if (indexPath.row == 6)
    {
        cell.nameLabel.text = @"家乡";
        if (self.currentModel.cityname.length > 0) {
            cell.summaryLabel.text = [NSString stringWithFormat:@"%@,%@", self.currentModel.provincename, self.currentModel.cityname];
            cell.summaryLabel.textColor = Color_Black_323232;
        }
        else
        {
            cell.summaryLabel.text = @"请选择";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
    }
    else if (indexPath.row == 7)
    {
        cell.nameLabel.text = @"出生年月日";
        if (self.currentModel.birthday.length > 0) {
            cell.summaryLabel.text = self.currentModel.birthday;
            cell.summaryLabel.textColor = Color_Black_323232;
        }
        else
        {
            cell.summaryLabel.text = @"请选择";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
    }
    else if (indexPath.row == 8)
    {
        cell.nameLabel.text = @"工作经验";
        if (self.currentModel.jobexp.length > 0) {
            cell.summaryLabel.text = self.currentModel.jobexp;
            cell.summaryLabel.textColor = Color_Black_323232;
        }
        else
        {
            cell.summaryLabel.text = @"请选择";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
    }
    else if (indexPath.row == 9)
    {
        cell.nameLabel.text = @"预计到岗时间";
        if (self.currentModel.exparrtimestring.length > 0) {
            cell.summaryLabel.text = self.currentModel.exparrtimestring;
            cell.summaryLabel.textColor = Color_Black_323232;
        }
        else
        {
            cell.summaryLabel.text = @"请选择";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
    }
    else if (indexPath.row == 10)
    {
        cell.nameLabel.text = @"自我介绍";
        if (self.currentModel.selfdes.length > 0) {
            cell.summaryLabel.text = @"已填写";
            cell.summaryLabel.textColor = Color_Black_323232;
        }
        else
        {
            cell.summaryLabel.text = @"请填写";
            cell.summaryLabel.textColor = Color_Black_A5A5A5;
        }
    }
    else if (indexPath.row == 11)
    {
        cell.nameLabel.text = @"添加职业照";
        cell.rightImageView.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //头像
    if (indexPath.row == 0) {
        [self openPhotoView];
    }
    else if (indexPath.row == 1)
    {
        [BRTFViewController start:@"姓名" detail:self.currentModel.name des:@"" placeholder:@"请填写姓名" complete:^(NSString * _Nonnull text) {
            [self saveNameWithStr:text];
        }];
    }
    else if (indexPath.row == 2)
    {
        XYActionSheetViewController *action = [XYActionSheetViewController show:xy_sex complete:^(NSString * _Nonnull title) {
            [self saveSexWithStr:title];
        }];
        action.headTitle = @"性别";
    }
    else if (indexPath.row == 3)
    {
        BRTFViewController *tf = [BRTFViewController start:@"手机号" detail:self.currentModel.mobile des:@"" placeholder:@"请填写手机号" complete:^(NSString * _Nonnull text) {
            [self saveTelWithStr:text];
        }];
        tf.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if (indexPath.row == 4)
    {
        [BRTFViewController start:@"微信号" detail:self.currentModel.wechat des:@"" placeholder:@"请填写微信号" complete:^(NSString * _Nonnull text) {
            [self saveWechatWithStr:text];
        }];
    }
    else if (indexPath.row == 5)
    {
        XYActionSheetViewController *action = [XYActionSheetViewController show:xy_degree complete:^(NSString * _Nonnull title) {
            [self saveDegreeWithStr:title];
        }];
        action.headTitle = @"学历";
    }
    else if (indexPath.row == 6)
    {
        FYAddressPickerView *add = [FYAddressPickerView showWithComplete:^(FYAddressModel * _Nonnull add) {
            [self saveHomeAddWithStr:[NSString stringWithFormat:@"%@,%@", add.province, add.city] code:[NSString stringWithFormat:@"%@,%@", add.proCode, add.cityCode]];
        }];
        add.comp = 2;
    }
    else if (indexPath.row == 7)
    {
        XYAlertDatePickerView *datePicker = [XYAlertDatePickerView ShowAlertDatePickerWithNameStr:@"出生年月日" withViewController:self withSureBlock:^(id returnData) {
            [self seveBirthdayWithStr:returnData];
        }];
        datePicker.datePicker.minimumDate = [NSDate setYear:1900];
        datePicker.datePicker.maximumDate = [NSDate date];
    }
    else if (indexPath.row == 8)
    {
        XYActionSheetViewController *action = [XYActionSheetViewController show:xy_exp complete:^(NSString * _Nonnull title) {
            [self seveJobExpWithStr:title];
        }];
        action.headTitle = @"工作经验";
    }
    else if (indexPath.row == 9)
    {
        XYActionSheetViewController *action = [XYActionSheetViewController show:xy_injob_time complete:^(NSString * _Nonnull title) {
            [self seveExparrtimeWithStr:title];
        }];
        action.headTitle = @"预计到岗时间";
    } else if (indexPath.row == 10) {
        C_ResumeIntroViewController *VC = [C_ResumeIntroViewController new];
        VC.selfdes = self.currentModel.selfdes;
        [VC.saveSubject subscribeNext:^(id  _Nullable x) {
            self.currentModel.selfdes = x;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        }];
        [self createViewWithController:VC andNavType:YES andLoginType:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Anno750(110);
}

- (void)saveUserInfoData
{
    NSDictionary *params = @{};
    [[NetworkManager instance] sendReq:params pageUrl:XY_C_ResumeInfoData urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSDictionary *dict = [result[@"data"] firstObject];
            C_Mine_ResumeModel *model = [[C_Mine_ResumeModel alloc]initWithModelDict:dict];
            self.currentModel = model;
            self.currentModel.pandc = [NSString stringWithFormat:@"%@,%@",model.provincename, model.cityname];
            self.footerView.img1 = self.currentModel.jobphotoone;
            self.footerView.img2 = self.currentModel.jobphototwo;
            self.footerView.img3 = self.currentModel.jobphotothree;
            [self.footerView configImgs];
            [self.tableView reloadData];
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}

//相机调用
- (void)openPhotoView
{
    [XYPickPhotoUtils pickPhoto:self complete:^(UIImage * _Nonnull img) {
        [[OSSManager share] uploadImage:img withSize:(CGSizeMake(400, 400)) withBlock:^(id  _Nonnull result) {
            NSString *imageStr = result;
            NSDictionary *params = @{
                                     @"photo":imageStr
                                     };
            [self saveResumeInfoDataWithParams:params withStr:nil];
        }];
    }];
}

// 保存姓名
- (void)saveNameWithStr:(NSString *)name {
    NSDictionary *params = @{
                             @"name":name
                             };
    [self saveResumeInfoDataWithParams:params withStr:nil];
}

//保存性别
- (void)saveSexWithStr:(NSString *)sex
{
    NSDictionary *params = @{
                             @"sex":sex
                             };
    [self saveResumeInfoDataWithParams:params withStr:nil];
}

// 保存电话
- (void)saveTelWithStr:(NSString *)tel {
    NSDictionary *params = @{
                             @"mobile":tel
                             };
    [self saveResumeInfoDataWithParams:params withStr:nil];
}
// 保存微信号
- (void)saveWechatWithStr:(NSString *)wx {
    NSDictionary *params = @{
                             @"wechat":wx
                             };
    [self saveResumeInfoDataWithParams:params withStr:nil];
}

//保存学历
- (void)saveDegreeWithStr:(NSString *)degree
{
    NSString *edu = [self transEdu:degree];
    NSDictionary *params = @{
                             @"education":edu,
                             };
    [self saveResumeInfoDataWithParams:params withStr:degree];
}
// 保存家乡
- (void)saveHomeAddWithStr:(NSString *)add code:(NSString *)code {
    NSDictionary *params = @{
                             @"pandc":code
                             };
    [self saveResumeInfoDataWithParams:params withStr:add];
}

//保存出生年月
- (void)seveBirthdayWithStr:(NSString *)str
{
    NSDictionary *params = @{
                             @"birthday":str,
                             };
    [self saveResumeInfoDataWithParams:params withStr:nil];
}

//保存工作经验
- (void)seveJobExpWithStr:(NSString *)str
{
    NSDictionary *params = @{
                             @"jobexp":str,
                             };
    [self saveResumeInfoDataWithParams:params withStr:nil];
}

//保存预计到岗时间
- (void)seveExparrtimeWithStr:(NSString *)str
{
    NSInteger type = 0;
    if ([str isEqualToString:@"随时到岗"]) {
        type = 0;
    }
    else if ([str isEqualToString:@"三天内"])
    {
        type = 1;
    }
    else if ([str isEqualToString:@"一周内"])
    {
        type = 3;
    }
    else if ([str isEqualToString:@"两周内"])
    {
        type = 4;
    }
    else if ([str isEqualToString:@"一个月内"])
    {
        type = 5;
    }
    else if ([str isEqualToString:@"超过一个月"])
    {
        type = 6;
    }
    NSDictionary *params = @{
                             @"exparrtime":@(type),
                             };
    [self saveResumeInfoDataWithParams:params withStr:str];
}

//保存图片1
- (void)sevejobphotooneWithStr:(NSString *)str
{
    NSDictionary *params = @{
                             @"jobphotoone":str,
                             };
    [self saveResumeInfoDataWithParams:params withStr:nil];
}


//保存图片2
- (void)sevejobphototwoWithStr:(NSString *)str
{
    NSDictionary *params = @{
                             @"jobphototwo":str,
                             };
    [self saveResumeInfoDataWithParams:params withStr:nil];
}


//保存图片3
- (void)sevejobphotothreeWithStr:(NSString *)str
{
    NSDictionary *params = @{
                             @"jobphotothree":str,
                             };
    [self saveResumeInfoDataWithParams:params withStr:nil];
}



- (void)saveResumeInfoDataWithParams:(NSDictionary *)params withStr:(NSString *)str
{
    [[NetworkManager instance] sendReq:params pageUrl:XY_C_SaveResumeInfoData urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSArray *array = [params allKeys];
            NSIndexPath *indexPath;
            if ([array containsObject:@"photo"]) {
                self.currentModel.photo = params[@"photo"];
                indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            }
            else if ([array containsObject:@"name"]) {
                self.currentModel.name = params[@"name"];
                indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            }
            else if ([array containsObject:@"sex"])
            {
                self.currentModel.sex = params[@"sex"];
                indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            }
            else if ([array containsObject:@"mobile"])
            {
                self.currentModel.mobile = params[@"mobile"];
                indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
            }
            else if ([array containsObject:@"wechat"])
            {
                self.currentModel.wechat = params[@"wechat"];
                indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
            }
            else if ([array containsObject:@"education"])
            {
                self.currentModel.education = [params[@"education"] integerValue];
                self.currentModel.educationname = str;
                indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
            }
            else if ([array containsObject:@"pandc"])
            {
                // TODO: 家乡
                self.currentModel.pandc = str;
                NSArray *arr = [str componentsSeparatedByString:@","];
                if (arr.count > 0) {
                    self.currentModel.provincename = arr[0];
                }
                if (arr.count > 1) {
                    self.currentModel.cityname  = arr[1];
                }
                indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
            }
            else if ([array containsObject:@"birthday"])
            {
                self.currentModel.birthday = params[@"birthday"];
                indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
            }
            else if ([array containsObject:@"jobexp"])
            {
                self.currentModel.jobexp = params[@"jobexp"];
                indexPath = [NSIndexPath indexPathForRow:8 inSection:0];
            }
            else if ([array containsObject:@"exparrtime"])
            {
                self.currentModel.exparrtimestring = str;
                indexPath = [NSIndexPath indexPathForRow:9 inSection:0];
            } else if ([array containsObject:@"jobphotoone"]) {
                self.currentModel.jobphotoone = params[@"jobphotoone"];
                self.footerView.img1 = self.currentModel.jobphotoone;
                [self.footerView configImgs];
                return;
            } else if ([array containsObject:@"jobphototwo"]) {
                self.currentModel.jobphototwo = params[@"jobphototwo"];
                self.footerView.img2 = self.currentModel.jobphototwo;
                [self.footerView configImgs];
                return;
            } else if ([array containsObject:@"jobphotothree"]) {
                self.currentModel.jobphotothree = params[@"jobphotothree"];
                self.footerView.img3 = self.currentModel.jobphotothree;
                [self.footerView configImgs];
                return;
            }
            
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}

//- (void)loadResumeData
//{
//    NSDictionary *params = @{};
//    [[NetworkManager instance] sendReq:params pageUrl:XY_C_ResumeInfoData urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
//        if (successCode == 0) {
//            NSDictionary *dict = [result[@"data"] firstObject];
//            C_Mine_ResumeModel *model = [[C_Mine_ResumeModel alloc]initWithModelDict:dict];
//            self.currentModel = model;
//            NSArray *array = dict[@"jexps"];
//            NSMutableArray *mArray = [NSMutableArray array];
//            for (NSDictionary *dic in array) {
//                C_Mine_Resume_JobExpModel *model = [[C_Mine_Resume_JobExpModel alloc]initWithModelDict:dic];
//                [mArray addObject:model];
//            }
//            self.currentModel.jexps = mArray;
//            [self.tableView reloadData];
//        }
//        else
//        {
//            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
//        }
//    } errorBlock:^(id error) {
//
//    }];
//}

- (NSString *)transEdu:(NSString *)edu {
    if ([edu isEqualToString:@"不限"]) {
        return @"10";
    } else if ([edu isEqualToString:@"小学"]) {
        return @"20";
    } else if ([edu isEqualToString:@"初中"]) {
        return @"30";
    } else if ([edu isEqualToString:@"高中"]) {
        return @"40";
    } else if ([edu isEqualToString:@"中专"]) {
        return @"41";
    } else if ([edu isEqualToString:@"大专"]) {
        return @"50";
    } else if ([edu isEqualToString:@"本科"]) {
        return @"60";
    } else if ([edu isEqualToString:@"硕士"]) {
        return @"70";
    } else if ([edu isEqualToString:@"博士"]) {
        return @"80";
    }
    return @"";
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
