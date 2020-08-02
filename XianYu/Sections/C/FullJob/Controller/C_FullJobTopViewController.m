//
//  C_FullJobTopViewController.m
//  XianYu
//
//  Created by lmh on 2019/7/27.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJobTopViewController.h"
#import "CityMarkCell.h"
#import "DSectionIndexItemView.h"
#import "DSectionIndexView.h"

#import "CityHeaderFooterView.h"

@interface C_FullJobTopViewController ()<UITableViewDelegate, UITableViewDataSource, CityMarkCellDelegate, DSectionIndexViewDelegate,DSectionIndexViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *keyArray;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *hotArray;

@property (nonatomic, strong) DSectionIndexView *sectionIndexView;

@property (strong, nonatomic) NSMutableArray *sections;




@end

@implementation C_FullJobTopViewController

- (RACSubject *)mySubject
{
    if (!_mySubject) {
        self.mySubject = [RACSubject subject];
    }
    return _mySubject;
}

- (NSMutableArray *)keyArray
{
    if (!_keyArray) {
        self.keyArray = [NSMutableArray array];
    }
    return _keyArray;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



- (NSMutableArray *)hotArray
{
    if (!_hotArray) {
        self.hotArray = [NSMutableArray array];
    }
    return _hotArray;
}

- (NSMutableArray *)sections
{
    if (!_sections) {
        self.sections = [NSMutableArray array];
    }
    return _sections;
}


#define kSectionIndexWidth 40.f
#define kSectionIndexHeight 360.f
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _sectionIndexView.frame = CGRectMake(CGRectGetWidth(self.tableView.frame) - kSectionIndexWidth, Anno750(100), kSectionIndexWidth, KScreenHeight - Anno750(100));
    _sectionIndexView.backgroundColor = Color_Ground_F5F5F5;
    [_sectionIndexView setBackgroundViewFrame];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.sectionIndexView reloadItemViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitle:@"城市" titleColor:Color_Nav_FontColor andNavColor:Color_White];
    [self setNavTitle:@"城市切换" titleColor:Color_Black_464646 andNavColor:Color_White];
    [self drawBackButtonWithBlackStatus:NavigationBackType_Black];
    [self createUI];
    [self _initIndexView];
    [self loadLocalCityData];
    [self getCityData];
    

    // Do any additional setup after loading the view.
}

- (void)_initIndexView
{
    _sectionIndexView = [[DSectionIndexView alloc] init];
    _sectionIndexView.backgroundColor = [UIColor clearColor];
    _sectionIndexView.dataSource = self;
    _sectionIndexView.delegate = self;
    _sectionIndexView.isShowCallout = YES;
    _sectionIndexView.calloutViewType = CalloutViewTypeForUserDefined;
    _sectionIndexView.calloutDirection = SectionIndexCalloutDirectionLeft;
    _sectionIndexView.calloutMargin = 100.f;
    [self.view addSubview:self.sectionIndexView];
}

//- (void)goBack
//{
////    [self dismissViewControllerAnimated:YES completion:nil];
//}



- (void)createUI{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight)) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView setSeparatorColor:Color_Line_EBEBEB];
    self.tableView.backgroundColor = Color_Ground_F5F5F5;
    self.tableView.sectionIndexColor = Color_Line_EBEBEB;
    self.tableView.sectionIndexBackgroundColor = Color_Blue_32A060;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotArray.count > 0) {
        return self.sections.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 1;
    }
    else
    {
        NSArray *array = self.dataArray[section - 2];
        return array.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 2) {
        static NSString *identifier_current = @"currentCell";
        CityMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_current];
        if (!cell) {
            cell = [[CityMarkCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_current];
            cell.viewController = self;
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.section == 0)
        {
            CityModel *model = [[UserManager share] getCityValue];
            [cell configureWithArray:@[model] section:indexPath.section];
        }
        else
        {
            [cell configureWithArray:self.hotArray section:indexPath.section];
        }
        return cell;
    }
    else
    {
        static NSString *identifier_city = @"cityCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_city];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier_city];
            cell.textLabel.font = [UIFont systemFontOfSize:Anno750(28)];
            cell.textLabel.textColor = Color_Black_878787;
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSArray *array = self.dataArray[indexPath.section - 2];
        CityModel *model = array[indexPath.row];
        cell.textLabel.text = model.name;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *section_view = @"sectionView";
    CityHeaderFooterView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:section_view];
    if (!sectionView) {
        sectionView = [[CityHeaderFooterView alloc]initWithReuseIdentifier:section_view];
    }
    if (section == 0)
    {
        sectionView.headerLabel.text = @"当前城市";
        
    }
    else if (section == 1)
    {
        sectionView.headerLabel.text = @"热门城市";
    }
    else
    {
        NSString *keyStr = self.keyArray[section - 2];
        sectionView.headerLabel.text = [keyStr uppercaseString];
    }
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 2) {
        CityMarkCell *cell = [[CityMarkCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"currentCell"];
        if (indexPath.section == 0) {
            CityModel *model = [[CityModel alloc]init];
            model.name = @"中国";
            return [cell configureWithArray:@[model] section:indexPath.section];
        }
        else if (indexPath.section == 1)
        {
            return [cell configureWithArray:self.hotArray section:indexPath.section];
        }
    }
    return Anno750(80);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return Anno750(60);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section > 1) {
        NSArray *array =self.dataArray[indexPath.section - 2];
        CityModel *model = array[indexPath.row];
        if (self.isFullJob) {
            [UserManager share].currentFullJobCityModel = model;
        }
        else
        {
            [UserManager share].currentPartJobCityModel = model;
        }
        if (self.mySubject) {
            [self.mySubject sendNext:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)clickCityButtonSection:(NSInteger)section withTag:(NSInteger)tag
{

    if (section == 1) {
        CityModel *model = self.hotArray[tag];
        if (self.isFullJob) {
            [UserManager share].currentFullJobCityModel = model;
        }
        else
        {
            [UserManager share].currentPartJobCityModel = model;
        }
        if (self.mySubject) {
            [self.mySubject sendNext:nil];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        CityModel *model = [[UserManager share] getCityValue];
        
        if (self.isFullJob) {
            [UserManager share].currentFullJobCityModel = model;
        }
        else
        {
            [UserManager share].currentPartJobCityModel = model;
        }
        if (self.mySubject) {
            [self.mySubject sendNext:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)getCityData
{
    NSDictionary *params = @{};
    [[NetworkManager instance] sendReq:params pageUrl:@"gethotcitylist" urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSLog(@"---------");
            NSArray *array = result[@"data"];
            for (NSDictionary *dict in array) {
                CityModel *model = [[CityModel alloc]initWithModelDict:dict];
                [self.hotArray addObject:model];
            }
            
            [self.sections insertObject:@"" atIndex:0];
            [self.sections insertObject:@"热门" atIndex:1];
            for (NSString *str in self.keyArray) {
                [self.sections addObject:[str uppercaseString]];
            }
//            [self.keyArray insertObject:@"" atIndex:0];
//            [self.keyArray insertObject:@"当前选择城市" atIndex:0];
            [self.tableView reloadData];
            [self.sectionIndexView reloadItemViews];
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
}

- (NSInteger)numberOfItemViewForSectionIndexView:(DSectionIndexView *)sectionIndexView
{
    return self.tableView.numberOfSections;
}


- (DSectionIndexItemView *)sectionIndexView:(DSectionIndexView *)sectionIndexView itemViewForSection:(NSInteger)section
{
    DSectionIndexItemView *itemView = [[DSectionIndexItemView alloc] init];
    itemView.titleLabel.text = [self.sections objectAtIndex:section];
    itemView.titleLabel.font = [UIFont systemFontOfSize:12];
    itemView.titleLabel.textColor = [UIColor darkGrayColor];
    itemView.titleLabel.highlightedTextColor = [UIColor redColor];
    itemView.titleLabel.shadowColor = [UIColor whiteColor];
    itemView.titleLabel.shadowOffset = CGSizeMake(0, 1);
    
    return itemView;
}

- (UIView *)sectionIndexView:(DSectionIndexView *)sectionIndexView calloutViewForSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 80, 80);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor redColor];
    label.font = [UIFont boldSystemFontOfSize:36];
    label.text = [self.sections objectAtIndex:section];
    label.textAlignment = NSTextAlignmentCenter;
    [label.layer setCornerRadius:label.frame.size.width/2];
    [label.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [label.layer setBorderWidth:3.0f];
    [label.layer setShadowColor:[UIColor blackColor].CGColor];
    [label.layer setShadowOpacity:0.8];
    [label.layer setShadowRadius:5.0];
    [label.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    return label;
}

- (NSString *)sectionIndexView:(DSectionIndexView *)sectionIndexView
               titleForSection:(NSInteger)section
{
    return [self.sections objectAtIndex:section];
}

- (void)sectionIndexView:(DSectionIndexView *)sectionIndexView didSelectSection:(NSInteger)section
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadLocalCityData
{
    NSDictionary *dict = [[UserManager share] loadLocalCityAllData];
    NSArray *kArray = [dict allKeys];
      NSArray *sortDescriptors_key = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:nil ascending:YES]];
    NSArray *sortedArray_key = [kArray sortedArrayUsingDescriptors:sortDescriptors_key];
    
    self.keyArray = [NSMutableArray arrayWithArray:sortedArray_key];
    for (NSString *keys in self.keyArray) {
        NSArray *array = dict[keys];
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            CityModel *model = [[CityModel alloc]initWithModelDict:dic];
            [mArray addObject:model];
        }
        [self.dataArray addObject:mArray];
    }
    NSLog(@"--------------");
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
