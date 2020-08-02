//
//  C_Mine_JobExperienceViewController.m
//  XianYu
//
//  Created by lmh on 2019/7/3.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_JobExperienceViewController.h"
#import "C_Mine_EditUserInfoListCell.h"
#import "XYActionSheetViewController.h"

@interface C_Mine_JobExperienceViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;



@end

@implementation C_Mine_JobExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"工作经历" titleColor:Color_Black_464646 andNavColor:Color_White];
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight)) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 0.0001f;
    self.tableView.sectionHeaderHeight = 0.0001f;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier_list = @"listCell";
    C_Mine_EditUserInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_list];
    if (!cell) {
        cell = [[C_Mine_EditUserInfoListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_list];
    }
    cell.summaryLabel.hidden = NO;
    cell.rightImageView.hidden = NO;
    cell.userImageView.hidden = YES;
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"工作类型";
    }
    else if (indexPath.row == 1)
    {
        cell.nameLabel.text = @"工作职位";
    }
    else if (indexPath.row == 2)
    {
        cell.nameLabel.text = @"开始时间";
    }
    else if (indexPath.row == 3)
    {
        cell.nameLabel.text = @"结束时间";
    }
    else if (indexPath.row == 4)
    {
        cell.nameLabel.text = @"工作地点";
    }
    else
    {
        cell.nameLabel.text = @"工作描述";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        XYActionSheetViewController *VC = [XYActionSheetViewController show:@[@"全职",@"兼职"] complete:^(NSString * _Nonnull title) {
            
        }];
    }
    else if (indexPath.row == 1)
    {
        
    }
    else if (indexPath.row == 2)
    {
        
    }
    else if (indexPath.row == 3)
    {
        
    }
    else if (indexPath.row == 4)
    {
        
    }
    else if (indexPath.row == 5)
    {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Anno750(110);
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
