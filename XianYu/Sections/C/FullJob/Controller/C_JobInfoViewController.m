//
//  C_JobInfoViewController.m
//  XianYu
//
//  Created by lmh on 2019/6/27.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_JobInfoViewController.h"
#import "C_JobInfoCell.h"
#import "C_JobInfoHeadView.h"
#import "C_JobLocationCell.h"

#import "C_JobInfoListCell.h"
#import "C_FullJob_TipCell.h"
#import "C_FullJob_DescribeCell.h"
#import "C_DeliverSuccessView.h"
#import "C_FullJobDetailModel.h"
#import "C_MapViewController.h"
#import "CReportViewController.h"
#import "C_JobReleaseCell.h"

@interface C_JobInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *deliverButton;

@property (nonatomic, strong) UIButton *contactButton;

@property (nonatomic, strong) C_FullJobDetailModel *currentModel;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation C_JobInfoViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavRightItem:@"" withStrColor:Color_White itemImageStr:@"icon_c_jobdetail_share" withIsEnable:YES];
    [self drawBackButtonWithBlackStatus:(NavigationBackType_Black)];
    [self setNavTitle:@"" titleColor:Color_White andNavColor:Color_White];
    [self createUI];
    [self loadJobDetailData];
    [CommanTool addLoadView:self.view];
}


- (void)clickOneRightNavBarItem
{
//    [UserManager.share shareToWX:model.jobtype jobId:model.id];
    [[UserManager share] shareToWX:[NSString stringWithFormat:@"%ld",self.currentModel.jobtype] jobId:[NSString stringWithFormat:@"%@",self.jobId]];
}

- (void)createUI{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight - Anno750(98))) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = 0.0001;
    self.tableView.sectionHeaderHeight = 0.0001;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self createBottomView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < 6) {
        return 1;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier_info = @"infoCell";
        C_JobInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_info];
        if (!cell) {
            cell = [[C_JobInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_info];
        }
        [cell configureWithModel:self.currentModel];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        static NSString *identifier_location = @"locationCell";
        C_JobLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_location];
        if (!cell) {
            cell = [[C_JobLocationCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_location];
        }
        [cell configureWithModel:self.currentModel];
        return cell;
    }
    else if (indexPath.section == 2)
    {
        static NSString *identifier_tip = @"tipCell";
        C_FullJob_TipCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_tip];
        if (!cell) {
            cell = [[C_FullJob_TipCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_tip];
        }
        cell.reportAction = ^{
            CReportViewController *VC = [[UIStoryboard storyboardWithName:@"CMine" bundle:nil]instantiateViewControllerWithIdentifier:@"CReportViewController"];
            VC.jobid = [NSString stringWithFormat:@"%@",self.jobId];
            VC.jobtype = [NSString stringWithFormat:@"%ld",self.currentModel.jobtype];
            [self createViewWithController:VC andNavType:YES andLoginType:YES];
        };
        return cell;
    }
    else if (indexPath.section == 3)
    {
        static NSString *identifier_describe = @"describeCell";
        C_FullJob_DescribeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_describe];
        if (!cell) {
            cell = [[C_FullJob_DescribeCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_describe];
        }
        [cell.summaryLabel setLabelSpaceAlign:(NSTextAlignmentLeft) withValue:self.currentModel.jobdesc withFont:font750(28) withLineSpace:Anno750(12)];
        return cell;
    }
    else if (indexPath.section == 4)
    {
        static NSString *identifier_company = @"companyCell";
        C_JobReleaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_company];
        if (!cell) {
            cell = [[C_JobReleaseCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_company];
        }
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:self.currentModel.shoplogo] placeholderImage:[UIImage imageNamed:@"placehold"]];
        cell.userImageView.layer.cornerRadius = Anno750(6);
        cell.userImageView.backgroundColor = Color_Ground_F5F5F5;
        cell.titleLabel.text = @"门店信息";
        cell.nameLabel.text = self.currentModel.shopname;
        cell.jobLabel.text = [NSString stringWithFormat:@"%@ | %@", self.currentModel.industry, self.currentModel.scale];
        cell.imgStr = self.currentModel.environmentimgs;
        return cell;
    }
    else if (indexPath.section == 5)
    {
        static NSString *identifier_company = @"companyCell";
        C_JobReleaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_company];
        if (!cell) {
            cell = [[C_JobReleaseCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_company];
        }
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:self.currentModel.rephoto] placeholderImage:[UIImage imageNamed:@"placehold"]];
        cell.userImageView.layer.cornerRadius = Anno750(50);
        cell.titleLabel.text = @"职位发布者";
        cell.userImageView.backgroundColor = Color_Ground_F5F5F5;
        cell.nameLabel.text = self.currentModel.rename;
        cell.jobLabel.text = self.currentModel.reposition;
        cell.imgStr = @"";
        return cell;
    }
    else
    {
        static NSString *identifier_list = @"listCell";
        C_JobInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_list];
        if (!cell) {
            cell = [[C_JobInfoListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_list];
        }
        C_PartJobInfoListModel *model = self.dataArray[indexPath.row];
        [cell configureWithPartJobModel:model];
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 6) {
        C_JobInfoHeadView *headView = [[C_JobInfoHeadView alloc]initWithFrame:(CGRectMake(0, 0, KScreenWidth, Anno750(96)))];
        headView.nameLabel.text = @"热门推荐";
        return headView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        C_MapViewController *VC = [C_MapViewController new];
        VC.addressName = self.currentModel.address;
        [self createViewWithController:VC andNavType:YES andLoginType:YES];
    }
    else if (indexPath.section == 6)
    {
        C_PartJobInfoListModel *model = self.dataArray[indexPath.row];
        C_JobInfoViewController *VC = [C_JobInfoViewController new];
        VC.jobId = model.id;
        VC.cityModel = self.cityModel;
        [self createViewWithController:VC andNavType:YES andLoginType:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 6) {
        return Anno750(96);
    }
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        C_JobInfoCell *cell = [[C_JobInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"listCel"];
        CGFloat cell_h = [cell createWealfareLabelView:self.currentModel.welfare];
        return cell_h + Anno750(200);
    }
    else if (indexPath.section == 1)
    {
        NSString *str = self.currentModel.address;
        CGFloat cell_h = [str getSpaceLabelWothFont:[UIFont systemFontOfSize:font750(30)] withWidth:(KScreenWidth - 22 - 22 - 108 - 10) lineSpace:0];
        if (cell_h > 63) {
            return Anno750(29) + Anno750(56) + Anno750(13) + Anno750(40) + Anno750(20) + cell_h + Anno750(48);
        }
        else
        {
            return Anno750(29) + Anno750(56) + Anno750(13) + Anno750(40) + Anno750(20) + 63 + Anno750(48);
        }
        
    }
    else if (indexPath.section == 2)
    {
        return Anno750(150);
    }
    else if (indexPath.section == 3)
    {
        CGFloat cellH = [self.currentModel.jobdesc getSpaceLabelWothFont:[UIFont systemFontOfSize:Anno750(28)] withWidth:(KScreenWidth - Anno750(88)) lineSpace:Anno750(12)];
//        [JSFactory getSize:self.currentModel.jobdesc maxSize:(CGSizeMake(KScreenWidth - Anno750(88), CGFLOAT_MAX)) font:[UIFont systemFontOfSize:Anno750(28)]];
        return cellH + Anno750(140);
    }
    else if (indexPath.section == 4) {
        if (self.currentModel.shoplogo.length > 0 || self.currentModel.shopname.length > 0) {
             if (!self.currentModel.environmentimgs || self.currentModel.environmentimgs.length == 0) {
                 return Anno750(240);
             } else {
                 return Anno750(396);
             }
            
        }
        return 0;
    }
    else if (indexPath.section == 5)
    {
        if (self.currentModel.rephoto.length > 0 || self.currentModel.rename.length > 0) {
            return Anno750(240);
        }
        return 0;
    }
    
    return Anno750(250);
}

- (void)createBottomView
{
    self.deliverButton = [JSFactory creatButtonWithTitle:@"投简历" textFont:font750(30) titleColor:Color_Blue_32A060 backGroundColor:Color_White];
    [[self.deliverButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self sendDelivery];
    }];
    self.contactButton = [JSFactory creatButtonWithTitle:@"立即沟通" textFont:font750(30) titleColor:Color_White backGroundColor:Color_Blue_32A060];
    [[self.contactButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[IMManager share] connentJobid:self.jobId withJobType:self.currentModel.jobtype viewController:self];;
    }];
    
    
    [self.view addSubview:self.deliverButton];
    [self.view addSubview:self.contactButton];
    [self.deliverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(@0);
        make.height.equalTo(@(Anno750(98)));
        make.width.equalTo(@(KScreenWidth/2.0));
    }];
    [self.contactButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(KScreenWidth/2.0));
        make.right.bottom.equalTo(@0);
        make.height.equalTo(@(Anno750(98)));
    }];
}

- (void)createDeliverySuceessView
{
    C_DeliverSuccessView *successView = [[NSBundle mainBundle] loadNibNamed:@"C_DeliverSuccessView" owner:self options:nil].firstObject;
    successView.frame = self.navigationController.view.bounds;
    [self.navigationController.view addSubview:successView];
}

- (void)sendDelivery
{

    NSDictionary *params = @{
                             @"id":self.jobId,
                             @"type":@(self.currentModel.jobtype)
                             
                             };
    [[NetworkManager instance] sendReq:params pageUrl:@"deliveryresume" urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            [self.deliverButton setTitleColor:UIColorFromRGB(0x828282) forState:(UIControlStateNormal)];
            [self.deliverButton setTitle:@"已投递" forState:(UIControlStateNormal)];
            [self createDeliverySuceessView];
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}


- (void)loadJobDetailData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.jobId forKey:@"id"];
    if ([UserManager share].latitude > 0) {
        [params setObject:@([UserManager share].latitude) forKey:@"lad"];
    }
    else
    {
        [params setObject:@"" forKey:@"lad"];
    }
    
    if ([UserManager share].longitude > 0) {
        [params setObject:@([UserManager share].longitude) forKey:@"lon"];
    }
    else
    {
        [params setObject:@"" forKey:@"lon"];
    }

    [[NetworkManager instance] sendReq:params pageUrl:@"fulljobdetailed" urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        NSLog(@"%@", result);
        if (successCode == 0) {
            NSDictionary *dict = [result[@"data"] firstObject];
            C_FullJobDetailModel *model = [[C_FullJobDetailModel alloc]initWithModelDict:dict];
            self.currentModel = model;
            [self.tableView reloadData];
            [self loadInfoRecommendData];
            if (self.currentModel.deliverystatus == 1) {
                [self.deliverButton setTitleColor:UIColorFromRGB(0x828282) forState:(UIControlStateNormal)];
                [self.deliverButton setTitle:@"已投递" forState:(UIControlStateNormal)];
            }
            if (model.iscan != 0) {
//                self.clickButton.hidden = NO;
                self.contactButton.hidden = YES;
                [self.deliverButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.bottom.right.equalTo(@0);
                    make.height.equalTo(@(Anno750(98)));
                    
                }];
            }
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}

- (void)loadInfoRecommendData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.currentModel.classid forKey:@"classid"];
    [params setObject:self.cityModel.code forKey:@"citycode"];
    if ([UserManager share].latitude > 0) {
        [params setObject:@([UserManager share].latitude) forKey:@"lad"];
    }
    else
    {
        [params setObject:@"" forKey:@"lad"];
    }
    
    if ([UserManager share].longitude > 0) {
        [params setObject:@([UserManager share].longitude) forKey:@"lon"];
    }
    else
    {
        [params setObject:@"" forKey:@"lon"];
    }
    [[NetworkManager instance] sendReq:params pageUrl:@"getrecommendjoblist" urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSArray *araay = result[@"data"];
            
            for (NSDictionary *dict in araay) {
                C_PartJobInfoListModel *model = [[C_PartJobInfoListModel alloc]initWithModelDict:dict];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
            [CommanTool removeViewType:4 parentView:self.view];
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
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
