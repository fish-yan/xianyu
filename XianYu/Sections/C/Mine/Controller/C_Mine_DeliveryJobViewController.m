//
//  C_Mine_DeliveryJobViewController.m
//  XianYu
//
//  Created by lmh on 2019/7/3.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_DeliveryJobViewController.h"
#import "C_Mine_DeliverJobListCell.h"
#import "C_Mine_DeliveryListModel.h"
#import "C_JobInfoViewController.h"
#import "C_PartJobInfoViewController.h"

@interface C_Mine_DeliveryJobViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation C_Mine_DeliveryJobViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray= [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"我投递的岗位" titleColor:Color_Black_464646 andNavColor:Color_White];
    [self drawBackButtonWithBlackStatus:(NavigationBackType_Black)];
    [self createUI];
    [self createFresh:self.tableView];
    [self loadDeliveryListData];
    [CommanTool addLoadView:self.tableView];
}

- (void)clickRefreshHeader
{
    self.currentPage = 1;
    [self loadDeliveryListData];
}

- (void)clickRefreshfooter
{
    self.currentPage++;
    [self loadDeliveryListData];
}


- (void)createUI{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight)) style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = Color_Ground_F5F5F5;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 0.0001f;
    self.tableView.sectionHeaderHeight = 0.0001f;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier_list = @"listCell";
    C_Mine_DeliverJobListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_list];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"C_Mine_DeliverJobListCell" owner:self options:nil].firstObject;
        
    }
    C_Mine_DeliveryListModel *model = self.dataArray[indexPath.section];
    [cell configureWithModel:model];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    C_Mine_DeliveryListModel *model = self.dataArray[indexPath.section];
    if (model.jobtype == 0) {
        C_JobInfoViewController *VC = [C_JobInfoViewController new];
        VC.jobId = model.jobid;
        VC.cityModel = [UserManager share].currentFullJobCityModel;
        [self createViewWithController:VC andNavType:YES andLoginType:YES];
    }
    else if (model.jobtype == 1)
    {
        C_PartJobInfoViewController *VC = [C_PartJobInfoViewController new];
        VC.jobID = model.jobid;
        VC.cityModel = [UserManager share].currentPartJobCityModel;
        [self createViewWithController:VC andNavType:YES andLoginType:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    C_Mine_DeliveryListModel *model = self.dataArray[indexPath.section];
    CGFloat cell_h = [model.shopaudit getSpaceLabelWothFont:[UIFont systemFontOfSize:Anno750(28)] withWidth:(KScreenWidth - 32) lineSpace:Anno750(12)];
    
    return 93 + 10 + cell_h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return Anno750(20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001f;
}

- (void)loadDeliveryListData
{
    NSDictionary *params = @{};
    [[NetworkManager instance] sendReq:params pageUrl:@"deliverylist" urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            if (self.currentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *array = result[@"data"];
            NSMutableArray *mArray = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                C_Mine_DeliveryListModel *model = [[C_Mine_DeliveryListModel alloc]initWithModelDict:dict];
                [mArray addObject:model];
            }
            if ([self.tableView.mj_header isRefreshing]) {
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }
            if ([self.tableView.mj_footer isRefreshing]) {
                if (mArray.count == 20) {
                    [self.tableView.mj_footer endRefreshing];
                }
                else
                {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [self.dataArray addObjectsFromArray:mArray];
            if (self.dataArray.count > 0) {
                [CommanTool removeViewType:4 parentView:self.view];
                [CommanTool removeViewType:4 parentView:self.tableView];
                [self.tableView reloadData];
            }
            else
            {
                [CommanTool removeViewType:4 parentView:self.view];
                [CommanTool removeViewType:4 parentView:self.tableView];
                [self.tableView reloadData];
                [CommanTool addNoDataView:self.tableView withImage:@"icon_no_data" contentStr:@"暂无内容"];
            }
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
