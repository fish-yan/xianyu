
//
//  C_FullJobSelectTypeViewController.m
//  XianYu
//
//  Created by lmh on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJobSelectTypeViewController.h"
#import "C_FullJobSelectCityCell.h"
#import "C_PartJobSelectCell.h"
#import "C_FullJobTypeSelectHeaderView.h"


@interface C_FullJobSelectTypeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *leftArray;

@property (nonatomic, strong) NSMutableArray *rightArray;



@property (nonatomic, strong) C_FullJobTypeSelectHeaderView *headView;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation C_FullJobSelectTypeViewController

- (RACSubject *)dataSubject
{
    if (!_dataSubject) {
        self.dataSubject = [RACSubject subject];
    }
    return _dataSubject;
}

- (NSMutableArray *)leftArray
{
    if (!_leftArray) {
        self.leftArray = [NSMutableArray array];
    }
    return _leftArray;
}

- (NSMutableArray *)rightArray
{
    if (!_rightArray) {
        self.rightArray = [NSMutableArray array];
    }
    return _rightArray;
}

- (NSMutableArray *)selectArray
{
    if (!_selectArray) {
        self.selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"全职岗位选择" titleColor:Color_Gray_828282 andNavColor:Color_White];
    [self drawBackButtonWithBlackStatus:(NavigationBackType_Black)];
    [self createNavRightItem:@"确定" withStrColor:Color_Gray_828282 itemImageStr:nil withIsEnable:YES];
    self.leftArray = [NSMutableArray arrayWithArray:[UserManager share].jobList];
    [self createHeaderView];
    [self createUI];
    [self.tableView reloadData];
    [self changeDataArray];
    [self refreshTableView];
    [self refreshMyView];
    
    // Do any additional setup after loading the view.
}

- (void)clickOneRightNavBarItem
{
    if (self.selectArray.count > 0) {
        JobDetailModel *model = [[JobDetailModel alloc]init];
        model.name = @"全部";
        [self.selectArray insertObject:model atIndex:0];
        NSMutableArray *mArray = [NSMutableArray array];
        for (JobDetailModel *model in self.selectArray) {
            NSDictionary *dict = [model mj_keyValues];
            [mArray addObject:dict];
        }
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:mArray forKey:@"XY_FullJob_Top"];
        [userDefaults synchronize];
        if (self.dataSubject) {
            [self.dataSubject sendNext:nil];
        }
    }
    else
    {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:nil forKey:@"XY_FullJob_Top"];
        [userDefaults synchronize];
        if (self.dataSubject) {
            [self.dataSubject sendNext:nil];
        }
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请选择全职岗位" duration:1.0f];
        return;
    }
    [super goBack];
    
}


- (void)createHeaderView
{
    self.headView = [[C_FullJobTypeSelectHeaderView alloc]init];
    [self.headView.clearSubject subscribeNext:^(id  _Nullable x) {
        [self.selectArray removeAllObjects];
        [self refreshMyView];
        [self.collectionView reloadData];
    }];
    [self.headView.removeSubject subscribeNext:^(id  _Nullable x) {
        JobDetailModel *model = (JobDetailModel *)x;
        [self.selectArray removeObject:model];
         [self.collectionView reloadData];
        [self refreshMyView];
       
    }];
    [self.view addSubview:self.headView];
}

- (void)refreshMyView
{
    if (self.selectArray.count == 0) {
        self.headView.hidden = YES;

    }
    else
    {
        self.headView.hidden = NO;
    }
    CGFloat view_h = [self.headView createSelectButtonArray:self.selectArray];
    self.headView.frame = CGRectMake(0, NavRectHeight, KScreenWidth, view_h);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame), Anno750(230), KScreenHeight - NavRectHeight - CGRectGetMaxY(self.headView.frame));
    self.lineView.frame = CGRectMake(Anno750(230), CGRectGetMinY(self.tableView.frame), 0.5, CGRectGetHeight(self.tableView.frame));
    self.collectionView.frame = CGRectMake(Anno750(230), CGRectGetMinY(self.tableView.frame), KScreenWidth - Anno750(230), CGRectGetHeight(self.tableView.frame));
}

- (void)createUI{
    
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, 0, Anno750(230), KScreenHeight )) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = Color_White;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:(CGRectMake(Anno750(230), CGRectGetMinY(self.tableView.frame), KScreenWidth - Anno750(230), CGRectGetHeight(self.tableView.frame))) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = Color_White;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[C_PartJobSelectCell class] forCellWithReuseIdentifier:@"identifier_select"];
    [self.view addSubview:self.collectionView];
    
    self.lineView = [JSFactory createLineView];
    self.lineView.frame = CGRectMake(Anno750(230), CGRectGetMinY(self.tableView.frame), 0.5, CGRectGetHeight(self.tableView.frame));
    [self.view addSubview:self.lineView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier_left = @"leftCell";
    C_FullJobSelectCityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_left];
    if (!cell) {
        cell = [[C_FullJobSelectCityCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_left];
        [cell remarkNameLabel];
    }
    JobTypeModel *model = self.leftArray[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = Color_White;
    cell.nameLabel.highlightedTextColor = Color_Black_464646;
    cell.lineView.backgroundColor = Color_Blue_32A060;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobTypeModel *model = self.leftArray[indexPath.row];
    self.rightArray = model.detailList;
    [self.collectionView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Anno750(80);
}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.rightArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    C_PartJobSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier_select" forIndexPath:indexPath];
    JobDetailModel *model = self.rightArray[indexPath.row];
    cell.nameLabel.text = model.name;
    
    
    if ([self.selectArray containsObject:model]) {
        cell.nameLabel.textColor = Color_Blue_32A060;
        cell.backgroundColor = UIColorFromRGB(0xEFF7F2);
        
    }
    else
    {
        cell.nameLabel.textColor = Color_Black_A5A5A5;
        cell.backgroundColor = Color_Ground_F5F5F5;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JobDetailModel *model = self.rightArray[indexPath.row];
    if ([self.selectArray containsObject:model]) {
        [self.selectArray removeObject:model];
    }
    else
    {
        if (self.selectArray.count >= 5) {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"最多可选择5个" duration:1.0f];
            return;
        }
        [self.selectArray addObject:model];
    }
   
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [self refreshMyView];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((KScreenWidth - Anno750(230) - Anno750(88))/3.0, Anno750(60));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return Anno750(20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return Anno750(10);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(Anno750(20), Anno750(24), Anno750(20), Anno750(24));
}

#pragma mark --------- 默认选中 --------
- (void)refreshTableView
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    if ([self.tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.tableView.delegate tableView:self.tableView  didSelectRowAtIndexPath:indexPath];
    }
}

- (void)createHeadViewArray
{
    
}

- (void)changeDataArray
{
    NSMutableArray *mArray = [NSMutableArray array];
    for (JobTypeModel *model in self.leftArray) {
        for (JobDetailModel *rightModel in model.detailList) {
            for (JobDetailModel *myModel in self.selectArray) {
                if (myModel.id == rightModel.id) {
                    NSLog(@"------------");
                }
                if (myModel.id == rightModel.id) {
                    [mArray addObject:rightModel];
                }
            }
        }
    }
    self.selectArray = [NSMutableArray arrayWithArray:mArray];
    
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
