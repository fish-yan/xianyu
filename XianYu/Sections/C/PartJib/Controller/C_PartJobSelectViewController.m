//
//  C_PartJobSelectViewController.m
//  XianYu
//
//  Created by lmh on 2019/7/7.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_PartJobSelectViewController.h"
#import "C_PartJobDeleteCell.h"
#import "C_PartJobSelectCell.h"
#import "C_PartJobSelectHeadView.h"

@interface C_PartJobSelectViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *dataArray;



@property (nonatomic, strong) C_PartJobSelectHeadView *headView;

@end

@implementation C_PartJobSelectViewController

- (RACSubject *)saveSubject
{
    if (!_saveSubject) {
        self.saveSubject = [RACSubject subject];
    }
    return _saveSubject;
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
    [self setNavTitle:@"兼职岗位选择" titleColor:Color_Black_323232 andNavColor:Color_White];
    [self createNavRightItem:@"确定" withStrColor:Color_Black_464646 itemImageStr:nil withIsEnable:YES];
    [self createHeaderView];
    [self createUI];
    [self changeDataArray];
    
    // Do any additional setup after loading the view.
}

- (void)clickOneRightNavBarItem
{
    if (self.selectArray.count == 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:nil forKey:@"XY_PartJob_Top"];
        [userDefaults synchronize];
        if (self.saveSubject) {
            [self.saveSubject sendNext:nil];
        }
    }
    else
    {
        if (self.saveSubject) {
            NSDictionary *dict = @{
                                   @"id":@"10000",
                                   @"name":@"全部"
                                   };
            
            [self.selectArray insertObject:dict atIndex:0];
            NSArray *array = [NSArray arrayWithArray:self.selectArray];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:array forKey:@"XY_PartJob_Top"];
            [userDefaults synchronize];
            if (self.saveSubject) {
                [self.saveSubject sendNext:nil];
            }
        }
    }
    [super goBack];
    
}

- (void)createHeaderView
{
    self.headView = [[C_PartJobSelectHeadView alloc]init];
    [self.headView.clearSubject subscribeNext:^(id  _Nullable x) {
        [self.selectArray removeAllObjects];
        [self refreshMyView];
        [self.collectionView reloadData];
    }];
    [self.headView.removeSubject subscribeNext:^(id  _Nullable x) {
        NSDictionary *model = (NSDictionary *)x;
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
    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame) + Anno750(10), KScreenWidth, KScreenHeight - CGRectGetHeight(self.headView.frame) - Anno750(10));
}



- (void)createUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:(CGRectMake(0, NavRectHeight + Anno750(10), KScreenWidth, KScreenHeight)) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = Color_White;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[C_PartJobSelectCell class] forCellWithReuseIdentifier:@"identifier_select"];
    [self.collectionView registerClass:[C_PartJobDeleteCell class] forCellWithReuseIdentifier:@"identifier_delete"];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    C_PartJobSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier_select" forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.row];
//    "id":6004,
//    "name":"电话客服"
    cell.nameLabel.text = dict[@"name"];
    if ([self.selectArray containsObject:dict]) {
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
    NSDictionary *dict = self.dataArray[indexPath.row];
    if ([self.selectArray containsObject:dict]) {
        [self.selectArray removeObject:dict];
    }
    else
    {
        if (self.selectArray.count >= 5) {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"最多可选择5个" duration:1.0f];
            return;
        }
        [self.selectArray addObject:dict];
    }
    
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [self refreshMyView];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KScreenWidth - Anno750(48) - Anno750(60))/4.0, Anno750(60));
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
    return UIEdgeInsetsMake(0, Anno750(20), 0, Anno750(20));
}

- (void)loadPartJobTypeData
{
    NSDictionary *dict = [self loadLocalPartJobType];
    self.dataArray = dict[@"RECORDS"];
    [self.collectionView reloadData];
}

- (NSDictionary *)loadLocalPartJobType
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"partpost" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        //DLog(@"JSON解码失败");
        return nil;
    } else {
        return jsonObj;
    }
}

- (void)changeDataArray
{
    [self loadPartJobTypeData];
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *dict in self.dataArray) {
        for (NSDictionary *dic in self.selectArray) {
            if ([dict[@"id"] intValue] == [dic[@"id"] intValue]) {
                [mArray addObject:dic];
            }
        }
    }
    self.selectArray = [NSMutableArray arrayWithArray:mArray];
    [self.collectionView reloadData];
    [self refreshMyView];
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
