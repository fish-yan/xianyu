
//
//  C_SearchJobViewController.m
//  XianYu
//
//  Created by lmh on 2019/7/10.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_SearchJobViewController.h"
#import "C_SearchHeadView.h"
#import "C_SearchHotCellCell.h"
#import "C_SearchReusableView.h"
#import "C_SearchTopView.h"
#import "C_FullJobListModel.h"
#import "C_FullJobListCell.h"
#import "C_JobInfoViewController.h"
#import "C_FullJobQuestionSelectView.h"
#import "C_PartJobSelectView.h"


@interface C_SearchJobViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) C_SearchHeadView *headView;

@property (nonatomic, strong) NSArray *hotArray;

@property (nonatomic, strong) NSArray *historyArray;

@property (nonatomic, strong) C_SearchTopView *topSearchView;

@property (nonatomic, assign) C_FullJobSelectOrderType orderType;

@property (nonatomic, strong) AreaModel *areaModel;

@property (nonatomic, strong) NSMutableArray *dataArray;


@property (nonatomic, strong) C_PartJobSelectView *questionView;

@property (nonatomic, strong) NSDictionary *areaDict;

@property (nonatomic, strong) NSDictionary *paixuDict;

@end

@implementation C_SearchJobViewController

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
    if (self.topSearchView && self.topSearchView != nil) {
        self.topSearchView.hidden = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.topSearchView.hidden = YES;
}

- (void)dealloc
{
    if (self.topSearchView && self.topSearchView != nil) {
        [self.topSearchView removeFromSuperview];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"" titleColor:Color_White andNavColor:Color_White];
    [self drawBackButtonWithBlackStatus:(NavigationBackType_Black)];
    [self createNavRightItem:@"搜索" withStrColor:Color_Gray_828282 itemImageStr:nil withIsEnable:YES];
    [self createTopSearchView];
    [self createCollectionView];
    [self createHeadView];
    [self createTableView];
    [self loadHistoryData];
    // Do any additional setup after loading the view.
}




- (void)clickOneRightNavBarItem
{
    self.currentPage = 1;
    self.areaDict = nil;
    self.areaModel = nil;
    self.orderType = 100;
    [self.headView.areaButton setTitle:@"全部区域" forState:(UIControlStateNormal)];
    [self.headView.distanceButton setTitle:@"距离最近" forState:(UIControlStateNormal)];
    [self clickSearchJob];
}


- (void)clickSearchJob
{
    
    
    if (self.topSearchView.printField.text.length == 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请输入搜索职位名称/公司" duration:1.0f];
        return;
    }
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"XY_App_Search_History"];
    if (![array containsObject:self.topSearchView.printField.text]) {
        NSMutableArray *mArray = [NSMutableArray arrayWithArray:array];
        if (array.count >= 10) {
            [mArray removeObjectAtIndex:0];
            [mArray addObject:self.topSearchView.printField.text];
        }
        else
        {
            [mArray addObject:self.topSearchView.printField.text];
        }
        self.historyArray = mArray;
        [[NSUserDefaults standardUserDefaults] setObject:self.historyArray forKey:@"XY_App_Search_History"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.areaModel.code.length > 0) {
        [params setObject:self.areaModel.code forKey:@"citycode"];
    }
    else
    {
        [params setObject:self.cityModel.code forKey:@"citycode"];
    }
    
    [params setObject:self.topSearchView.printField.text forKey:@"search"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.orderType] forKey:@"orderbytype"];
    if (self.orderType != C_FullJobSelectOrderType_Release && self.orderType != C_FullJobSelectOrderType_Distance && self.orderType != C_FullJobSelectOrderType_Hight) {
        [params setObject:@"juli asc" forKey:@"orderbytype"];
    }
    else if(self.orderType == C_FullJobSelectOrderType_Release)
    {
        [params setObject:@"createdate desc" forKey:@"orderbytype"];
    }
    else if (self.orderType == C_FullJobSelectOrderType_Distance)
    {
        [params setObject:@"juli asc" forKey:@"orderbytype"];
    }
    else if (self.orderType == C_FullJobSelectOrderType_Hight)
    {
        [params setObject:@"wage desc" forKey:@"orderbytype"];
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
    
    [[NetworkManager instance] sendReq:params pageUrl:@"searchfulljob" urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
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
            
            if (self.dataArray.count == 0) {
                [CommanTool removeViewType:4 parentView:self.view];
                [CommanTool removeViewType:4 parentView:self.tableView];
                [CommanTool addNoDataView:self.tableView withImage:@"icon_no_data" contentStr:@"暂无内容"];
            }
            else
            {
                [CommanTool removeViewType:4 parentView:self.view];
                [CommanTool removeViewType:4 parentView:self.tableView];
                [self.tableView reloadData];
            }
            
            self.tableView.hidden = NO;
            self.headView.hidden = NO;
            self.collectionView.hidden = YES;
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}

- (void)createTopSearchView{
    self.topSearchView = [[C_SearchTopView alloc]initWithFrame:(CGRectMake(Anno750(100), 7, KScreenWidth - Anno750(228), 44 - 14))];
    self.topSearchView.printField.returnKeyType = UIReturnKeySearch;
    self.topSearchView.printField.delegate = self;
    [self.topSearchView.printField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        if (x.length == 0) {
            if (self.tableView.hidden == NO) {
                self.tableView.hidden = YES;
                self.headView.hidden = YES;
                self.collectionView.hidden = NO;
                [self.collectionView reloadData];
            }
        }
    }];
    [JSFactory configureWithView:self.topSearchView cornerRadius:Anno750(4) isBorder:NO borderWidth:0 borderColor:nil];
    [self.navigationController.navigationBar addSubview:self.topSearchView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self clickOneRightNavBarItem];
    return YES;
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight - NavRectHeight)) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = Color_White;
    [self.collectionView registerClass:[C_SearchHotCellCell class] forCellWithReuseIdentifier:@"hotCell"];
    [self.collectionView registerClass:[C_SearchReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self loadHistoryData];
    [self loadHotSearchData];
}



- (void)createHeadView
{
    self.headView = [[C_SearchHeadView alloc]initWithFrame:(CGRectMake(0, NavRectHeight, KScreenWidth, Anno750(75)))];
    self.headView.hidden = YES;
    [[self.headView.areaButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.questionView && self.questionView != nil) {
            [self removeAearView];
        }
        else
        {
            [self createAlertViewWithType:(C_PartJobTableViewType_Area)];
        }
        self.currentPage = 1;
    }];
    [[self.headView.distanceButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.questionView && self.questionView != nil) {
            [self removeAearView];
        }
        else
        {
            [self createAlertViewWithType:(C_PartJobTableViewType_PaiXu)];
        }
        self.currentPage = 1;
    }];
    [self.view addSubview:self.headView];
}

- (void)createTableView
{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, CGRectGetMaxY(self.headView.frame), KScreenWidth, KScreenHeight - Anno750(75) - NavRectHeight)) style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = Color_Ground_F5F5F5;
    self.tableView.sectionFooterHeight = 0.001f;
    self.tableView.sectionHeaderHeight = 0.001f;
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self createFresh:self.tableView];
}

- (void)clickRefreshHeader
{
    self.currentPage = 1;
    [self clickSearchJob];
}

- (void)clickRefreshfooter
{
    self.currentPage++;
    [self clickSearchJob];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.historyArray.count;
    }
    else
    {
        return self.hotArray.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    C_SearchHotCellCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        NSString *str = self.historyArray[indexPath.row];
        cell.nameLabel.text = str;
    }
    else
    {
        NSDictionary *dict = self.hotArray[indexPath.row];
        cell.nameLabel.text = dict[@"classname"];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        C_SearchReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            reusableView.clearButton.hidden = NO;
            reusableView.nameLabel.text = @"搜索记录";
            if (self.historyArray.count > 0) {
                reusableView.clearButton.hidden = NO;
                reusableView.nameLabel.hidden = NO;
            }
            else
            {
                reusableView.clearButton.hidden = YES;
                reusableView.nameLabel.hidden = YES;
            }
            [[reusableView.clearButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"XY_App_Search_History"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                self.historyArray = nil;
                [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
            }];
        }
        else
        {
            reusableView.nameLabel.hidden = NO;
            reusableView.clearButton.hidden = YES;
            reusableView.nameLabel.text = @"热门搜索";
        }
        return reusableView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = nil;
    if (indexPath.section == 0) {
        str = self.historyArray[indexPath.row];
        
    }
    else if (indexPath.section == 1)
    {
        NSDictionary *dict = self.hotArray[indexPath.row];
        str = dict[@"classname"];
    }
    self.topSearchView.printField.text = str;
    self.currentPage = 1;
    self.orderType = 100;
    self.areaModel = nil;
    [self clickSearchJob];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.historyArray.count > 0) {
            return CGSizeMake(KScreenWidth, Anno750(102));
        }
        return CGSizeZero;
    }
    return CGSizeMake(KScreenWidth, Anno750(102));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KScreenWidth - Anno750(108))/4.0, Anno750(60));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return Anno750(20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(Anno750(20), Anno750(24), 0, Anno750(24));
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
    C_FullJobListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_list];
    if (!cell) {
        cell = [[C_FullJobListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_list];
    }
    C_FullJobListModel *model = self.dataArray[indexPath.section];
    [cell configureWithModel:model];
    [[cell.clickButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [self contractUser:nil];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    C_FullJobListModel *model = self.dataArray[indexPath.section];
    C_JobInfoViewController *VC = [C_JobInfoViewController new];
    VC.jobId = model.id;
    VC.cityModel = self.cityModel;
    [self createViewWithController:VC andNavType:YES andLoginType:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Anno750(313);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return Anno750(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (void)loadHistoryData
{
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"XY_App_Search_History"];

    self.historyArray = array;
    
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

- (void)loadHotSearchData
{
    NSDictionary *params = @{};
    [[NetworkManager instance] sendReq:params pageUrl:@"getrecommendlist" urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSArray *array = result[@"data"];
            self.hotArray = array;
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
            self.areaModel = nil;
            
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}


#pragma mark ------- 弹出层 -------
- (void)createAlertViewWithType:(C_PartJobTableViewType)type
{
    [self removeAearView];
    self.questionView = [[C_PartJobSelectView alloc]initWithFrame:(CGRectMake(0, Anno750(75) + NavRectHeight, KScreenWidth, KScreenHeight - NavRectHeight - Anno750(75)))];
    if (type == C_PartJobTableViewType_Area) {
        if (self.areaDict && self.areaDict != nil) {
            NSInteger num = [self.areaDict[@"num"] integerValue];
            self.questionView.cityModel = self.cityModel;
            [self.questionView refreshTableViewType:C_PartJobTableViewType_Area withName:@"" withDefautNum:num];
        }
        else
        {
            self.questionView.cityModel = self.cityModel;
            [self.questionView refreshTableViewType:C_PartJobTableViewType_Area withName:@"" withDefautNum:0];
        }
    }
    else if (type == C_PartJobTableViewType_PaiXu)
    {
        if (self.paixuDict && self.paixuDict != nil) {
            NSInteger num = [self.paixuDict[@"num"] integerValue];
            [self.questionView refreshTableViewType:C_PartJobTableViewType_PaiXu withName:@"" withDefautNum:num];
        }
        else
        {
            [self.questionView refreshTableViewType:C_PartJobTableViewType_PaiXu withName:@"" withDefautNum:0];
        }
    }
    [self.questionView.selectSubject subscribeNext:^(id  _Nullable x) {
        NSDictionary *dict = x;
        C_PartJobTableViewType myType = [dict[@"type"] integerValue];
        if (myType == C_PartJobTableViewType_Area) {
            self.areaModel = dict[@"name"];
            [self.headView.areaButton setTitle:self.areaModel.shortname forState:(UIControlStateNormal)];
            if ([self.areaModel.code isEqualToString:@"-1"]) {
                self.areaModel = nil;
            }
            self.areaDict = dict;
        }
        else if (myType == C_PartJobTableViewType_PaiXu)
        {
            self.paixuDict = dict;
            NSString *str = dict[@"name"];
            [self.headView.distanceButton setTitle:self.paixuDict[@"name"] forState:(UIControlStateNormal)];
            if ([str isEqualToString:@"距离最近"]) {
                self.orderType = C_FullJobSelectOrderType_Distance;
            }
            else if ([str isEqualToString:@"最新发布"])
            {
                self.orderType = C_FullJobSelectOrderType_Release;
            }
            else if ([str isEqualToString:@"工资最高"])
            {
                self.orderType = C_FullJobSelectOrderType_Hight;
            }
        }
        self.currentPage = 1;
        [self removeAearView];
        [self clickSearchJob];
    }];
    
    [self.view addSubview:self.questionView];
}


- (void)removeAearView
{
    if (self.questionView && self.questionView != nil) {
        [self.questionView removeFromSuperview];
        self.questionView = nil;
    }
}

- (void)clearSelectArea:(BOOL)selectArea withSelectPaixu:(BOOL)selectPaixu withSelectMoney:(BOOL)selectMoney
{
    if (selectArea) {
        self.areaModel = nil;
        [self.headView.areaButton setTitle:@"全部区域" forState:(UIControlStateNormal)];
    }
    if (selectPaixu) {
        self.paixuDict = nil;
        [self.headView.distanceButton setTitle:@"离我最近" forState:(UIControlStateNormal)];
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
