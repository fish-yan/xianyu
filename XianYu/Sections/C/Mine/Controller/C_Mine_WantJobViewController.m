//
//  C_Mine_WantJobViewController.m
//  XianYu
//
//  Created by lmh on 2019/7/3.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_WantJobViewController.h"
#import "C_Mine_EditUserInfoListCell.h"

@interface C_Mine_WantJobViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation C_Mine_WantJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"求职意向" titleColor:Color_Black_464646 andNavColor:Color_White];
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
    return 5;
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
        cell.nameLabel.text = @"求职类型";
    }
    else if (indexPath.row == 1)
    {
        cell.nameLabel.text = @"期望工作地点";
    }
    else if (indexPath.row == 2)
    {
        cell.nameLabel.text = @"期望薪资";
    }
    else if (indexPath.row == 2)
    {
        cell.nameLabel.text = @"期望日薪";
    }
    else
    {
        cell.nameLabel.text = @"期望职位";
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
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
