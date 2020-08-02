//
//  PartJobViewController.m
//  XianYu
//
//  Created by lmh on 2019/6/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_PartJobViewController.h"
#import "C_PartJobListCell.h"
#import "C_PartJobInfoViewController.h"

#import "C_PartJobTypeSelectView.h"
#import "C_PartJobSelectViewController.h"
#import "C_PartJobSelectView.h"
#import "C_PartJobListModel.h"
#import "C_FullJobTopViewController.h"

@interface C_PartJobViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) C_PartJobTypeSelectView *headerView;

@property (nonatomic, strong) NSMutableArray *partJobArray;

@property (nonatomic, strong) NSDictionary *partJobDict;

@property (nonatomic, strong) AreaModel *areaModel;

@property (nonatomic, strong) CityModel *cityModel;

@property (nonatomic, strong) NSDictionary *moneyDict;

@property (nonatomic, strong) NSDictionary *paixuDict;

@property (nonatomic, strong) NSDictionary *areaDict;

@property (nonatomic, strong) C_PartJobSelectView *selectView;

@property (nonatomic, strong) UIButton *navLeftButton;


@end

@implementation C_PartJobViewController

- (NSMutableArray *)partJobArray
{
    if (!_partJobArray) {
        self.partJobArray = [NSMutableArray array];
    }
    return _partJobArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.cityModel = [UserManager share].currentPartJobCityModel;
    
    [self createLeftItemButton:self.cityModel.name];
    if (!self.isShowLoad) {
        [CommanTool addLoadView:self.view];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navLeftButton.hidden = YES;
    [self removeViewSubSelectiew];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"兼职" titleColor:Color_Black_323232 andNavColor:Color_White];
    self.view.backgroundColor = Color_Ground_F5F5F5;
    self.cityModel = [UserManager share].currentPartJobCityModel;
    [self createLeftItemButton:self.cityModel.shortname];
    [self createHeadView];
    [self createUI];
    [self createFresh:self.tableView];
    [self loadLoaclPartJobHeadData];
    [self loadPartJobListData];
}

- (void)clickRefreshHeader
{
    self.currentPage = 1;
    [self loadPartJobListData];
}

- (void)clickRefreshfooter
{
    self.currentPage++;
    [self loadPartJobListData];
}

- (void)createLeftItemButton:(NSString *)itemStr
{
    if (self.navLeftButton && self.navLeftButton != nil) {
        [self.navLeftButton removeFromSuperview];
    }
    if (itemStr.length > 4) {
        itemStr = [NSString stringWithFormat:@"%@...", [itemStr substringFromIndex:4]];
    }
    CGSize size = [JSFactory getSize:itemStr maxSize:(CGSizeMake(CGFLOAT_MAX, 44)) font:[UIFont systemFontOfSize:font750(32)]];
    self.navLeftButton = [JSFactory creatButtonWithTitle:itemStr textFont:font750(28) titleColor:Color_Black_464646 backGroundColor:Color_White];
    [self.navLeftButton setImage:GetImage(@"icon_partjob_down_item") forState:(UIControlStateNormal)];
    self.navLeftButton.frame = CGRectMake(Anno750(24), AppStatusBar, size.width + Anno750(38), 44);
    [self.navLeftButton addTarget:self action:@selector(clickNavLeftItem) forControlEvents:(UIControlEventTouchUpInside)];
    [self.navLeftButton layoutButtonWithImageStyle:(ZJButtonImageStyleRight) imageTitleToSpace:Anno750(10)];
    [self.navigationController.view addSubview:self.navLeftButton];
    
}

- (void)clickNavLeftItem
{
    C_FullJobTopViewController *VC = [C_FullJobTopViewController new];
    [VC.mySubject subscribeNext:^(id  _Nullable x) {
        self.currentPage = 1;
        [self clearSelectConditionWithClearArea:YES withClearOther:YES withClearJob:YES];
        [self loadPartJobListData];
    }];
    [self createViewWithController:VC andNavType:YES andLoginType:YES];
}

- (void)createHeadView{
    self.headerView = [[C_PartJobTypeSelectView alloc]initWithFrame:(CGRectMake(0, NavRectHeight, KScreenWidth, Anno750(150)))];
    
    [self.headerView.clickSubject subscribeNext:^(id  _Nullable x) {
        NSInteger intX = [x integerValue];
        self.partJobDict = self.partJobArray[intX];
        [self removeViewSubSelectiew];
        [self clearSelectConditionWithClearArea:YES withClearOther:YES withClearJob:NO];
        [self loadPartJobListData];
    }];
    //编辑z兼职职位
    [[self.headerView.modifyButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self removeViewSubSelectiew];
        C_PartJobSelectViewController *VC = [C_PartJobSelectViewController new];
        VC.selectArray = [NSMutableArray arrayWithArray:[self.partJobArray copy]];
        [VC.selectArray removeObjectAtIndex:0];
        [VC.saveSubject subscribeNext:^(id  _Nullable x) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSArray *array = [userDefaults objectForKey:@"XY_PartJob_Top"];
            self.partJobArray = [NSMutableArray arrayWithArray:array];
            [self.headerView createJobItemViewWithArray:self.partJobArray];
            self.partJobDict = [self.partJobArray firstObject];
            [self loadLoaclPartJobHeadData];
        }];
        [self createViewWithController:VC andNavType:YES andLoginType:YES];
    }];
    
    //点击全部区域
    [[self.headerView.areaButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self clearSelectConditionWithClearArea:NO withClearOther:NO withClearJob:NO];
        if (self.selectView && self.selectView != nil) {
            if (self.selectView.queType == C_PartJobTableViewType_Area) {
                [self removeViewSubSelectiew];
            }
            else
            {
                [self removeViewSubSelectiew];
                [self createHeadSelectViewWithType:(C_PartJobTableViewType_Area)];
            }
            
        }
        else
        {
            [self createHeadSelectViewWithType:(C_PartJobTableViewType_Area)];
        }
    }];
    //点击结算方式
    [[self.headerView.typeButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.selectView && self.selectView != nil) {
            if (self.selectView.queType == C_PartJobTableViewType_MoneyType) {
                [self removeViewSubSelectiew];
            }
            else
            {
                [self removeViewSubSelectiew];
                [self createHeadSelectViewWithType:(C_PartJobTableViewType_MoneyType)];
            }
        }
        else
        {
            [self createHeadSelectViewWithType:(C_PartJobTableViewType_MoneyType)];
        }
    }];
    //点击推荐排序
    [[self.headerView.paixunButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        if (self.selectView && self.selectView != nil) {
            if (self.selectView.queType == C_PartJobTableViewType_PaiXu) {
                [self removeViewSubSelectiew];
            }
            else
            {
                [self removeViewSubSelectiew];
                [self createHeadSelectViewWithType:(C_PartJobTableViewType_PaiXu)];
            }
        }
        else
        {
            [self createHeadSelectViewWithType:(C_PartJobTableViewType_PaiXu)];
        }
    }];
    
    
    
    [self.view addSubview:self.headerView];
}

- (void)createUI{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, Anno750(150) + NavRectHeight, KScreenWidth, KScreenHeight - Anno750(150) - NavRectHeight - AppTabbarHeight)) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = 0.001f;
    self.tableView.sectionHeaderHeight = 0.001f;
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
    C_PartJobListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_list];
    if (!cell) {
        cell = [[C_PartJobListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_list];
    }
    C_PartJobListModel *model = self.dataArray[indexPath.section];
    [cell configureWithModel:model];
//    [[cell.contractButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [self contractWithModel:model];
//    }];
    
    cell.contractButton.tag = 10000 + indexPath.section;
    [cell.contractButton addTarget:self action:@selector(contractWithButton:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    C_PartJobListModel *model = self.dataArray[indexPath.section];
    C_PartJobInfoViewController *VC = [C_PartJobInfoViewController new];
    VC.jobID = model.id;
    VC.cityModel = self.cityModel;
    [self createViewWithController:VC andNavType:YES andLoginType:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return Anno750(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Anno750(240);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}


- (void)loadPartJobListData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"" forKey:@"classids"];
    NSString *partName = self.partJobDict[@"name"];
    if ([partName isEqualToString:@"全部"]) {
        [params setObject:@"" forKey:@"classids"];
    }
    else
    {
        [params setObject:self.partJobDict[@"id"] forKey:@"classids"];
    }
    
    if (self.areaModel.code.length > 0) {
        [params setObject:self.areaModel.code forKey:@"areacode"];
    }
    else
    {
        
        [params setObject:self.cityModel.code forKey:@"areacode"];
    }
    if (self.moneyDict == nil) {
        [params setObject:@"-1" forKey:@"wagetype"];
    }
    else
    {
        NSString *moneyStr = self.moneyDict[@"name"];
        if ([moneyStr isEqualToString:@"结算方式不限"]) {
            [params setObject:@"-1" forKey:@"wagetype"];
        }
        else if ([moneyStr isEqualToString:@"完工结"])
        {
            [params setObject:@"3" forKey:@"wagetype"];
        }
        else if ([moneyStr isEqualToString:@"日结"])
        {
            [params setObject:@"0" forKey:@"wagetype"];
        }
        else if ([moneyStr isEqualToString:@"周结"])
        {
            [params setObject:@"1" forKey:@"wagetype"];
        }
        else if ([moneyStr isEqualToString:@"月结"])
        {
            [params setObject:@"2" forKey:@"wagetype"];
        }
    }
    
    if (self.paixuDict == nil) {
        [params setObject:@"juli asc" forKey:@"orderbytype"];
    }
    else
    {
        NSString *paixuStr = self.partJobDict[@"name"];
        if ([paixuStr isEqualToString:@"距离最近"]) {
            [params setObject:@"juli asc" forKey:@"orderbytype"];
        }
        else if ([paixuStr isEqualToString:@"最新发布"])
        {
            [params setObject:@"updatedate desc" forKey:@"orderbytype"];
        }
        else if ([paixuStr isEqualToString:@"工资最高"])
        {
            [params setObject:@"wage desc" forKey:@"orderbytype"];
        }
    }
    
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
    [params setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"pageNum"];
    [params setObject:@"20" forKey:@"pageSize"];
    [[NetworkManager instance] sendReq:params pageUrl:@"partjoblist" urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            self.isShowLoad = YES;
            if (self.currentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *araay = result[@"data"];
            NSMutableArray *mArray = [NSMutableArray array];
            for (NSDictionary *dict in araay) {
                C_PartJobListModel *model = [[C_PartJobListModel alloc]initWithModelDict:dict];
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
                [self.tableView reloadData];
                [CommanTool removeViewType:4 parentView:self.view];
                [CommanTool removeViewType:4 parentView:self.tableView];
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

- (void)loadLoaclPartJobHeadData
{
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"XY_PartJob_Top"];
    
    if (array.count == 0) {
        NSDictionary *dict = @{
                               @"name":@"全部",
                               };
        [self.partJobArray addObject:dict];
    }
    else
    {
       self.partJobArray = [NSMutableArray arrayWithArray:array];
        NSDictionary *dict = [self.partJobArray firstObject];
        if (![dict[@"name"] isEqualToString:@"全部"]) {
            NSDictionary *dict = @{
                                   @"name":@"全部",
                                   };
            [self.partJobArray addObject:dict];
        }
    }
    
    
    
    
    
    
    
    [self.headerView createJobItemViewWithArray:self.partJobArray];
    self.partJobDict = [self.partJobArray firstObject];
    [self loadPartJobListData];
}

- (void)createHeadSelectViewWithType:(C_PartJobTableViewType)type
{
    [self removeViewSubSelectiew];
    self.selectView = [[C_PartJobSelectView alloc]initWithFrame:(CGRectMake(0, Anno750(150) + NavRectHeight, KScreenWidth, KScreenHeight - NavRectHeight - AppTabbarHeight - Anno750(150)))];
    if (type == C_PartJobTableViewType_Area) {
        if (self.areaDict && self.areaDict != nil) {
            NSInteger num = [self.areaDict[@"num"] integerValue];
            self.selectView.cityModel = self.cityModel;
            [self.selectView refreshTableViewType:C_PartJobTableViewType_Area withName:@"" withDefautNum:num];
        }
        else
        {
            self.selectView.cityModel = self.cityModel;
            [self.selectView refreshTableViewType:C_PartJobTableViewType_Area withName:@"" withDefautNum:0];
        }
    }
    else if (type == C_PartJobTableViewType_MoneyType)
    {
        if (self.moneyDict && self.moneyDict != nil) {
            NSInteger num = [self.moneyDict[@"num"] integerValue];
            [self.selectView refreshTableViewType:C_PartJobTableViewType_MoneyType withName:@"" withDefautNum:num];
        }
        else
        {
            [self.selectView refreshTableViewType:C_PartJobTableViewType_MoneyType withName:@"" withDefautNum:0];
        }
    }
    else if (type == C_PartJobTableViewType_PaiXu)
    {
        if (self.paixuDict && self.paixuDict != nil) {
            NSInteger num = [self.paixuDict[@"num"] integerValue];
            [self.selectView refreshTableViewType:C_PartJobTableViewType_PaiXu withName:@"" withDefautNum:num];
        }
        else
        {
            [self.selectView refreshTableViewType:C_PartJobTableViewType_PaiXu withName:@"" withDefautNum:0];
        }
    }
    [self.selectView.selectSubject subscribeNext:^(id  _Nullable x) {
        NSDictionary *dict = x;
        C_PartJobTableViewType myType = [dict[@"type"] integerValue];
        if (myType == C_PartJobTableViewType_Area) {
            self.areaModel = dict[@"name"];
            [self.headerView.areaButton setTitle:self.areaModel.shortname forState:(UIControlStateNormal)];
            if ([self.areaModel.code isEqualToString:@"-1"]) {
                self.areaModel = nil;
            }
            self.areaDict = dict;
            
        }
        else if (myType == C_PartJobTableViewType_MoneyType)
        {
            self.moneyDict = dict;
            [self.headerView.typeButton setTitle:self.moneyDict[@"name"] forState:(UIControlStateNormal)];
        }
        else if (myType == C_PartJobTableViewType_PaiXu)
        {
            self.paixuDict = dict;
            [self.headerView.paixunButton setTitle:self.paixuDict[@"name"] forState:(UIControlStateNormal)];
        }
        self.currentPage = 1;
        [self removeViewSubSelectiew];
        [self loadPartJobListData];
    }];
//
    
    [self.view addSubview:self.selectView];
}

- (void)removeViewSubSelectiew
{
    if (self.selectView && self.selectView != nil) {
        [self.selectView removeFromSuperview];
        self.selectView = nil;
    }
}

- (void)contractWithButton:(UIButton *)sender
{
    NSInteger senderTag = sender.tag - 10000;
    C_PartJobListModel *model = self.dataArray[senderTag];
   [[IMManager share] connentJobid:model.id withJobType:model.jobtype viewController:self];
}


- (void)clearSelectConditionWithClearArea:(BOOL)clearArea  withClearOther:(BOOL)clearOther withClearJob:(BOOL)clearJob
{
    if (clearArea) {
        self.areaModel = nil;
        self.areaDict = nil;
        self.cityModel = [UserManager share].currentPartJobCityModel;
        [self.headerView.areaButton setTitle:@"全部区域" forState:(UIControlStateNormal)];
    }
    
    if (clearOther) {
        self.paixuDict = nil;
        self.paixuDict = nil;
    }
    
    if (clearJob) {
        NSDictionary *dict = @{
                               @"name":@"全部",
                               };
        self.partJobDict = dict;
    }
    
    
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
