//
//  C_PartJobSelectView.m
//  XianYu
//
//  Created by lmh on 2019/7/22.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_PartJobSelectView.h"
#import "C_PartJobHeadSelectCell.h"

@implementation C_PartJobSelectView


- (RACSubject *)selectSubject
{
    if (!_selectSubject) {
        self.selectSubject = [RACSubject subject];
    }
    return _selectSubject;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray  = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = UIColorFromRGBA(0x000000, 0.3);
    }
    return self;
}

- (void)createUI
{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, 0, KScreenWidth, 0)) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = Color_White;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
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
    C_PartJobHeadSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_list];
    if (!cell) {
        cell = [[C_PartJobHeadSelectCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_list];
    }
    if (self.queType == C_PartJobTableViewType_Area) {
        AreaModel *model = self.dataArray[indexPath.row];
        cell.nameLabel.text = model.shortname;
    }
    else
    {
        cell.nameLabel.text = self.dataArray[indexPath.row];
    }
    
    if (self.selectNum == indexPath.row) {
        cell.arrawImageView.hidden = NO;
    }
    else
    {
        cell.arrawImageView.hidden = YES;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Anno750(80);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.selectSubject) {
        if (self.queType == C_PartJobTableViewType_Area) {
            AreaModel *model = self.dataArray[indexPath.row];
      
            NSDictionary *dict = @{
                                   @"name":model,
                                   @"num":@(indexPath.row),
                                   @"type":@(self.queType)
                                   };
            [self.selectSubject sendNext:dict];
        }
        else
        {
            NSDictionary *dict = @{
                                   @"name":self.dataArray[indexPath.row],
                                   @"num":@(indexPath.row),
                                   @"type":@(self.queType)
                                   };
            [self.selectSubject sendNext:dict];
        }
        
    }
    [self removeFromSuperview];
}


- (void)refreshTableViewType:(C_PartJobTableViewType)type withName:(NSString *)cityName withDefautNum:(NSInteger)num
{
    self.queType = type;
    self.selectNum = num;
    [self.dataArray removeAllObjects];
    if (type == C_PartJobTableViewType_Area) {
        [self loadLocalCityDataWithStr:self.cityModel.name];
        self.tableView.frame = CGRectMake(0, 0, KScreenWidth, Anno750(400));
    }
    else if (type == C_PartJobTableViewType_MoneyType)
    {
       
        NSArray *array = @[@"结算方式不限", @"完工结", @"日结", @"周结", @"月结"];
        [self.dataArray addObjectsFromArray:array];
        self.tableView.frame = CGRectMake(0, 0, KScreenWidth, self.dataArray.count * Anno750(80));
    }
    else if (type == C_PartJobTableViewType_PaiXu)
    {
       
        NSArray *array = @[@"距离最近", @"最新发布", @"工资最高"];
        [self.dataArray addObjectsFromArray:array];
        self.tableView.frame = CGRectMake(0, 0, KScreenWidth, self.dataArray.count * Anno750(80));
    }
    
    [self.tableView reloadData];
}


- (void)loadLocalCityDataWithStr:(NSString *)cityName
{
    if ([cityName containsString:@"市"]) {
        cityName = [cityName substringToIndex:cityName.length - 1];
    }
    NSArray *areaArray = nil;
    NSArray *priArray = [UserManager share].provinceList;
    
    for (int i = 0; i < priArray.count ; i++) {
        ProvinceModel *topModel = priArray[i];
        
        for (int y = 0; y < topModel.cityList.count; y++) {
            CityModel *model = topModel.cityList[y];
            if ([model.shortname isEqualToString:cityName]) {
                areaArray = model.areaList;
                break;
            }
        }
    }
    AreaModel *myModel = [[AreaModel alloc]init];
    myModel.code = @"-1";
    myModel.level = 1;
    myModel.name = @"全部区域";
    myModel.shortname = @"全部区域";
    [self.dataArray addObjectsFromArray:areaArray];
    [self.dataArray insertObject:myModel atIndex:0];
    
}



@end
