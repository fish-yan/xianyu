//
//  C_FullJobQuestionSelectView.m
//  XianYu
//
//  Created by lmh on 2019/7/14.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJobQuestionSelectView.h"
#import "ProvinceModel.h"
#import "C_PartJobHeadSelectCell.h"

@implementation C_FullJobQuestionSelectView

- (RACSubject *)mySubject{
    if (!_mySubject) {
        self.mySubject = [RACSubject subject];
    }
    return _mySubject;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
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
    self.leftTableView = [JSFactory creatTabbleViewWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.leftTableView.backgroundColor = Color_White;
//    self.rightbleView = [JSFactory creatTabbleViewWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.leftTableView.delegate = self;
//    self.rightbleView.delegate = self;
    self.leftTableView.dataSource = self;
//    self.rightbleView.dataSource = self;
    [self addSubview:self.leftTableView];
//    [self addSubview:self.rightbleView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        CGFloat bottom = self.frame.size.height - Anno750(80) * self.dataArray.count;
        bottom = MAX(bottom, Anno750(350));
        make.bottom.equalTo(@(-bottom));
    }];
//    [self.rightbleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.equalTo(@0);
//        make.left.equalTo(self.leftTableView.mas_right);
//        make.bottom.equalTo(self.leftTableView);
//    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (tableView == self.leftTableView) {
        return self.dataArray.count;
//    }
//    else
//    {
//        return 10;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView == self.leftTableView) {
//    C_PartJobHeadSelectCell
    static NSString *identifier_left = @"leftCell";
    C_PartJobHeadSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_left];
    if (!cell) {
        cell = [[C_PartJobHeadSelectCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_left];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.selectNum == indexPath.row) {
        cell.arrawImageView.hidden = NO;
        cell.backgroundColor = UIColor.whiteColor;
    }
    else
    {
        cell.arrawImageView.hidden = YES;
        cell.backgroundColor = UIColorFromRGB(0xf5f5f5);
    }
    AreaModel *model = self.dataArray[indexPath.row];
    cell.nameLabel.text = model.shortname;
    cell.lineView.backgroundColor = UIColorFromRGB(0xEBEBEB);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AreaModel *model = self.dataArray[indexPath.row];
    if (self.mySubject) {
        NSDictionary *dict = @{
                               @"name":model,
                               @"num":@(indexPath.row),
                               };
        [self.mySubject sendNext:dict];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView == self.leftTableView) {
        return Anno750(80);
//    }
//    else
//    {
//        return Anno750(66);
//    }
}


- (void)loadCityName:(NSString *)cityName withNum:(NSInteger)num
{
    self.selectNum = num;
    NSArray *areaArray = nil;
    NSArray *priArray = [UserManager share].provinceList;
    for (int i = 0; i < priArray.count ; i++) {
        ProvinceModel *topModel = priArray[i];
        for (int y = 0; y < topModel.cityList.count; y++) {
            CityModel *model = topModel.cityList[y];
            if ([model.name containsString:cityName]) {
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
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObjectsFromArray:areaArray];
    [self.dataArray insertObject:myModel atIndex:0];
    [self.leftTableView reloadData];
    [self refreshTableView];
}

- (void)loadPaymentWithNum:(NSInteger)num {
    self.selectNum = num;
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *str in xy_wantpayment) {
        AreaModel *m = [AreaModel new];
        m.name = str;
        m.shortname = str;
        m.code = @"1";
        [arr addObject:m];
    }
    self.dataArray = arr;
    [self.leftTableView reloadData];
    [self refreshTableView];
}

- (void)loadOtherWithNum:(NSInteger)num {
    self.selectNum = num;
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *str in @[@"推荐排序", @"最新发布", @"距离最近", @"工资最高"]) {
        AreaModel *m = [AreaModel new];
        m.name = str;
        m.shortname = str;
        m.code = @"1";
        [arr addObject:m];
    }
    self.dataArray = arr;
    [self.leftTableView reloadData];
    [self refreshTableView];
}

#pragma mark --------- 默认选中 --------
- (void)refreshTableView
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    if ([self.leftTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.leftTableView.delegate tableView:self.leftTableView  didSelectRowAtIndexPath:indexPath];
    }
}




@end
