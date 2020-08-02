//
//  FullJobViewController.m
//  XianYu
//
//  Created by lmh on 2019/6/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJobViewController.h"
#import "C_FullJobListCell.h"
#import "SDCycleScrollView.h"
#import "C_JobInfoViewController.h"
#import "C_FullJobHeaderView.h"
#import "XY_RCConversationViewController.h"

#import "C_FullJobQuestionSelectView.h"
#import "C_FullJobSelectTypeViewController.h"
#import "C_FullJobListModel.h"
#import "C_SearchJobViewController.h"
#import "C_FullJobTopViewController.h"
#import "C_BannerModel.h"


@interface C_FullJobViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) C_FullJobHeaderView *headerView;

@property (nonatomic, strong) AreaModel *areaModel;

@property (nonatomic, strong) CityModel *cityModel;

@property (nonatomic, strong) JobDetailModel *currentJobModel;

@property (nonatomic, strong) NSMutableArray *selectJobArray;

@property (nonatomic, assign) C_FullJobSelectOrderType orderType;

@property (nonatomic, strong) C_FullJobQuestionSelectView *questionView;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, assign) BOOL isScrollEnable;

@property(nonatomic, assign) CGFloat scroll_height;

@property (nonatomic, strong) NSMutableArray *bannerArray;

@property (nonatomic, strong) NSDictionary *areaDict;

@property (nonatomic, strong) NSDictionary *payDict;

@property (nonatomic, strong) AreaModel *payModel;

@property (nonatomic, strong) NSDictionary *otherDict;

@property (nonatomic, strong) AreaModel *otherModel;

@end

@implementation C_FullJobViewController

- (NSMutableArray *)selectJobArray
{
    if (!_selectJobArray) {
        self.selectJobArray = [NSMutableArray array];
    }
    return _selectJobArray;
}


- (NSMutableArray *)bannerArray
{
    if (!_bannerArray) {
        self.bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
//    [self loadFullJobListData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UPDATELOCATIONCITY" object:nil];
    [self removeAearView];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_Ground_F5F5F5;
    self.orderType = C_FullJobSelectOrderType_Advance;
    [self createScrollView];
    [self loadBannerData];
    [self createFresh:self.tableView];
    [[UserManager share] getCityValue];
    self.cityModel = [UserManager share].currentCityModel;
    self.scroll_height = 286 * KScreenWidth/750.0 - Anno750(53) - AppTabbarHeight;
//    274 * KScreenWidth/750.0 + Anno750(106) + Anno750(70) + Anno750(74) - Anno750(53) - 274 * KScreenWidth/750.0 + Anno750(53);
    [[UserManager share] judgeLocationWithBlock:^(BOOL result) {
        //可以定位
        if (result) {
            [[UserManager share] configureWithLocationWithBlock:^{
                self.cityModel = [UserManager share].currentFullJobCityModel;;
                [self.headerView.searchView refreshCityButton:self.cityModel];
            }];
            [self loadLocalFullJobHeadData];
        }
        else
        {
            [self loadLocalFullJobHeadData];
        }
    }];
}

- (void)clickRefreshHeader
{
    self.currentPage = 1;
    [self loadFullJobListData];
}

- (void)clickRefreshfooter
{
    self.currentPage++;
    [self loadFullJobListData];
}

- (void)createScrollView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, - AppStatusBar, KScreenWidth, KScreenHeight - AppTabbarHeight + AppStatusBar))];
    self.scrollView.contentSize = CGSizeMake(KScreenWidth, 286 * KScreenWidth/750.0 - Anno750(53) + KScreenHeight-AppTabbarHeight - AppStatusBar);
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self createHeadView];
    [self createUI];
}



- (void)createHeadView
{

    self.headerView = [[C_FullJobHeaderView alloc]initWithFrame:(CGRectMake(0, 0, KScreenWidth, 286 * KScreenWidth/750.0 + Anno750(208)))];
    self.headerView.viewController = self;
    [self.headerView loadHeadData];
//    [self.headerView.jobSelectView createJobItemViewWithArray:self.selectJobArray];
    self.cityModel = [UserManager share].currentCityModel;
    [[self.headerView.searchView.searchButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        C_SearchJobViewController *VC = [C_SearchJobViewController new];
        VC.cityModel = self.cityModel;
        [self createViewWithController:VC andNavType:YES andLoginType:YES];
    }];
    //切换城市
    [[self.headerView.searchView.cityButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        C_FullJobTopViewController *VC = [C_FullJobTopViewController new];
        VC.isFullJob = YES;
        [VC.mySubject subscribeNext:^(id  _Nullable x) {
            self.cityModel = [UserManager share].currentFullJobCityModel;
            
            [self.headerView.searchView refreshCityButton:[UserManager share].currentFullJobCityModel];
            self.areaModel = nil;
            self.currentPage = 1;
            [self clearSelectConditionWithClearArea:YES withOther:YES withClearJob:YES];
            [self loadFullJobListData];
        }];
        [self createViewWithController:VC andNavType:YES andLoginType:YES];
    }];
    [self.headerView loadHeadData];
    [[self.headerView.jobSelectView.modifyButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        C_FullJobSelectTypeViewController *VC = [C_FullJobSelectTypeViewController new];
        VC.selectArray = [NSMutableArray arrayWithArray:[self.selectJobArray copy]];
        [VC.selectArray removeObjectAtIndex:0];
        [VC.dataSubject subscribeNext:^(id  _Nullable x) {
            self.currentPage = 1;
            [self loadLocalFullJobHeadData];
        }];
        [self createViewWithController:VC andNavType:YES andLoginType:YES];
    }];
    
    [self.headerView.jobSelectView.clickSubject subscribeNext:^(id  _Nullable x) {
        [self clearSelectConditionWithClearArea:YES withOther:YES withClearJob:YES];
        NSInteger num = [x integerValue];
        if (self.selectJobArray.count == 0) {
            [self loadLocalFullJobHeadData];
        }
        self.currentJobModel = self.selectJobArray[num];
        self.currentPage = 1;
        [self loadFullJobListData];
    }];
    
    [[self.headerView.areaButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self clearSelectConditionWithClearArea:NO withOther:NO withClearJob:NO];
        [self scrillTopHeader];
        if (self.questionView && self.questionView.tag == 0) {
            [self removeAearView];
        }
        else
        {
            [self createAreaView:0];
        }
    }];
    [[self.headerView.distanceButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self scrillTopHeader];
        if (self.questionView && self.questionView.tag == 1) {
            [self removeAearView];
        }
        else
        {
            [self createAreaView:1];
        }
    }];
    [[self.headerView.releaseButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self scrillTopHeader];
        if (self.questionView && self.questionView.tag == 2) {
            [self removeAearView];
        }
        else
        {
            [self createAreaView:2];
        }
    }];
    [self.scrollView addSubview:self.headerView];
}

- (void)createUI{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, CGRectGetMaxY(self.headerView.frame), KScreenWidth, self.scrollView.contentSize.height - CGRectGetHeight(self.headerView.frame))) style:(UITableViewStylePlain)];
    self.tableView.sectionFooterHeight = 0.0001f;
    self.tableView.sectionHeaderHeight = 0.0001f;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.scrollView addSubview:self.tableView];
    //    [self createTableHeadView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier_list = @"listCell";
    C_FullJobListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_list];
    if (!cell) {
        cell = [[C_FullJobListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_list];
    }
    C_FullJobListModel *model = self.dataArray[indexPath.row];
    [cell configureWithModel:model];
    cell.clickButton.tag = indexPath.row + 10000;
    [cell.clickButton addTarget:self action:@selector(contractUser:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    C_FullJobListModel *model = self.dataArray[indexPath.row];
    C_JobInfoViewController *VC = [C_JobInfoViewController new];
    VC.jobId = model.id;
    VC.cityModel = self.cityModel;
    [self createViewWithController:VC andNavType:YES andLoginType:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Anno750(323);
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return  [self createTableHeadView];
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 274 * KScreenWidth/750.0 + Anno750(106) + Anno750(70) + Anno750(74) - Anno750(53);
//}


- (void)scrillTopHeader
{
    [self.scrollView setContentOffset:(CGPointMake(0, self.scroll_height)) animated:NO];
    
}


- (void)contractUser:(UIButton *)sender
{
    NSInteger senderTag = sender.tag - 10000;
    C_FullJobListModel *model = self.dataArray[senderTag];
    [[IMManager share] connentJobid:model.id withJobType:model.jobtype viewController:self];
}

- (void)createAreaView:(NSInteger)type
{
    [self removeAearView];
    self.questionView = [[C_FullJobQuestionSelectView alloc]initWithFrame:CGRectZero];
    self.questionView.tag = type;
    NSInteger num = 0;
    if (type == 0) {
        if (self.areaDict != nil) {
            num = [self.areaDict[@"num"] integerValue];
        }
        [self.questionView loadCityName:[UserManager share].currentFullJobCityModel.name withNum:num];
        self.headerView.areaButton.selected = YES;
    } else if (type == 1) {
        if (self.payDict != nil) {
            num = [self.payDict[@"num"] integerValue];
        }
        self.headerView.distanceButton.selected = YES;
        [self.questionView loadPaymentWithNum:num];
    } else if (type == 2) {
        if (self.otherDict != nil) {
            num = [self.otherDict[@"num"] integerValue];
        }
        self.headerView.releaseButton.selected = YES;
        [self.questionView loadOtherWithNum:num];
    }
    
    
    [self.questionView.mySubject subscribeNext:^(id  _Nullable x) {
        [self removeAearView];
        if (type == 0) {
            self.areaDict = x;
            self.areaModel = self.areaDict[@"name"];
            [self.headerView.areaButton setTitle:self.areaModel.shortname forState:(UIControlStateNormal)];
            if ([self.areaModel.code isEqualToString:@"-1"]) {
                self.areaModel = nil;
            }
        } else if (type == 1) {
            self.payDict = x;
            self.payModel = self.payDict[@"name"];
            [self.headerView.distanceButton setTitle:self.payModel.shortname forState:(UIControlStateNormal)];
        } else if (type == 2) {
            self.otherDict = x;
            self.otherModel = self.otherDict[@"name"];
            if ([self.otherModel.name isEqualToString:@"推荐排序"]) {
                self.orderType = C_FullJobSelectOrderType_Advance;
            } else if ([self.otherModel.name isEqualToString:@"最新发布"]) {
                self.orderType = C_FullJobSelectOrderType_Release;
            } else if ([self.otherModel.name isEqualToString:@"距离最近"]) {
                self.orderType = C_FullJobSelectOrderType_Distance;
            } else if ([self.otherModel.name isEqualToString:@"工资最高"]) {
                self.orderType = C_FullJobSelectOrderType_Hight;
            }
            [self.headerView.releaseButton setTitle:self.otherModel.shortname forState:(UIControlStateNormal)];
        }
        
        self.currentPage = 1;
        [self loadFullJobListData];
        [self.headerView layoutBtns];
    }];
    [self.tabBarController.view addSubview:self.questionView];
    [self.questionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.top.equalTo(@(CGRectGetMaxY(self.headerView.frame) - self.scroll_height - [UIApplication sharedApplication].statusBarFrame.size.height));

    }];
}

- (void)removeAearView
{
    self.headerView.areaButton.selected = NO;
    self.headerView.distanceButton.selected = NO;
    self.headerView.releaseButton.selected = NO;
    NSArray *array = self.tabBarController.view.subviews;
    for (UIView *view in array) {
        if ([view isKindOfClass:[C_FullJobQuestionSelectView class]]) {
            [view removeFromSuperview];
        }
    }
    self.questionView = nil;
}

- (void)loadFullJobListData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:@"" forKey:@"classids"];
    if (self.currentJobModel.id > 0) {
        [params setObject:[NSString stringWithFormat:@"%@",self.currentJobModel.id] forKey:@"classids"];
    }
    
    if (self.areaModel.code.length > 0) {
        [params setObject:self.areaModel.code forKey:@"areacode"];
    }
    else
    {
       
        [params setObject:self.cityModel.code forKey:@"areacode"];
    }
    
    
    
    [params setObject:[NSString stringWithFormat:@"%ld",self.orderType] forKey:@"orderbytype"];
    if (self.orderType == C_FullJobSelectOrderType_Advance) {
        [params setObject:@"" forKey:@"orderbytype"];
    }
    else if(self.orderType == C_FullJobSelectOrderType_Release)
    {
        [params setObject:@"createdate desc" forKey:@"orderbytype"];
    }
    else if (self.orderType == C_FullJobSelectOrderType_Distance)
    {
        [params setObject:@"juli asc" forKey:@"orderbytype"];
    } else if (self.orderType == C_FullJobSelectOrderType_Hight) {
        [params setObject:@"maxwage desc" forKey:@"orderbytype"];
    }
    [params setObject:self.payModel.shortname ?: @"" forKey:@"wagerange"];
    
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
    
    
    
    
//    NSDictionary *params = @{
//                             @"classids":INCASE_EMPTY(jobID, @""),
//                             @"areacode":areaID,
//                             @"orderbytype":orderbytype,
//                             @"wagerange":INCASE_EMPTY(nil, @""),
//                             @"lon":INCASE_EMPTY(nil, @""),
//                             @"lad":INCASE_EMPTY(nil, @"")
//                             };
    [params setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"pageNum"];
    [params setObject:@"20" forKey:@"pageSize"];
    [[NetworkManager instance] sendReq:params pageUrl:XY_FullJobListData urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            if (self.currentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *array = result[@"data"];
            NSMutableArray *mArray = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                C_FullJobListModel *model = [[C_FullJobListModel alloc]initWithModelDict:dict];
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


- (void)loadLocalFullJobHeadData
{
    [self.selectJobArray removeAllObjects];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"XY_FullJob_Top"];
    if (array.count == 0) {
        JobDetailModel *model = [[JobDetailModel alloc]init];
        model.name = @"全部";
        [self.selectJobArray addObject:model];
    }
    else
    {
        for (NSDictionary *dict in array) {
            JobDetailModel *model = [[JobDetailModel alloc]initWithModelDict:dict];
            [self.selectJobArray addObject:model];
        }
        JobDetailModel *myModel = [self.selectJobArray firstObject];
        if (![myModel.name isEqualToString:@"全部"]) {
            JobDetailModel *model = [[JobDetailModel alloc]init];
            model.name = @"全部";
            [self.selectJobArray insertObject:model atIndex:0];
        }
    }
    [self.headerView.jobSelectView createJobItemViewWithArray:self.selectJobArray];
    self.currentJobModel = [self.selectJobArray firstObject];
    [self loadFullJobListData];
}





- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        CGFloat view_offset = scrollView.contentOffset.y;
        if (view_offset >= self.scroll_height - Anno750(10)) {
            self.tableView.scrollEnabled = YES;
            self.headerView.backView.hidden = NO;
            NSLog(@"-----------------");
        }
        else
        {
            self.tableView.scrollEnabled = NO;
            self.headerView.backView.hidden = YES;
            NSLog(@"+++++++++++++++++=");
        }
    }
    if (scrollView == self.tableView) {
        CGFloat view_offset = scrollView.contentOffset.y;
        if (view_offset <= 0) {
            self.tableView.scrollEnabled = NO;
            self.scrollView.scrollEnabled = YES;
        }
        else
        {
            self.tableView.scrollEnabled = YES;
            self.scrollView.scrollEnabled = NO;;
        }
    }
    
    
}

- (void)loadBannerData
{
    NSDictionary *params = @{
                             @"pageNum":@"1",
                             @"pageSize":@"100"
                             };
    [[NetworkManager instance] sendReq:params pageUrl:@"getsowing" urlVersion:nil endLoad:NO viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSArray *array = result[@"data"];
            NSMutableArray *imageArray = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                C_BannerModel *model = [[C_BannerModel alloc]initWithModelDict:dict];
                [self.bannerArray addObject:model];
                [imageArray addObject:model.picture];
            }
            if (self.bannerArray.count > 0) {
                self.headerView.bannerView.imageURLStringsGroup = imageArray;
                self.headerView.bannerArray = self.bannerArray;
            }
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}

//清除筛选条件
- (void)clearSelectConditionWithClearArea:(BOOL)clearArea withOther:(BOOL)clearOther withClearJob:(BOOL)clearJob
{
    if (clearArea) {
        self.areaModel = nil;
        [self.headerView refreshArearButtonWithModel:self.areaModel];
    }
    if (clearOther) {
        self.orderType = C_FullJobSelectOrderType_Advance;
    }
    
    if (clearJob) {
        self.currentJobModel = nil;
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
