//
//  C_Mine_SetViewController.m
//  XianYu
//
//  Created by lmh on 2019/7/7.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_SetViewController.h"
#import "C_Mine_EditUserInfoListCell.h"
#import "LoginViewController.h"


@interface C_Mine_SetViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation C_Mine_SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"设置" titleColor:Color_Black_464646 andNavColor:Color_White];
    [self drawBackButtonWithBlackStatus:(NavigationBackType_Black)];
    [self createUI];
    [self createBottomView];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight)) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = Color_Ground_F5F5F5;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier_info = @"infoCell";
    C_Mine_EditUserInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_info];
    if (!cell) {
        cell = [[C_Mine_EditUserInfoListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_info];
    }
    cell.userImageView.hidden = YES;
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"关于我们";
        cell.summaryLabel.text = @"";
    }
    else if (indexPath.row == 1)
    {
        CGFloat folderSize =[[SDImageCache sharedImageCache] totalDiskSize]/1024.0/1024.0;
        //   NSLog(@"%f",folderSize);
        NSString * str111 = [NSString stringWithFormat:@"%.1fM",folderSize];
        cell.nameLabel.text = @"清除缓存";
        cell.summaryLabel.text = str111;
    }
    else
    {
        cell.nameLabel.text = @"鼓励评分";
        cell.summaryLabel.text = @"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    }
    else if (indexPath.row == 1)
    {
        [[UserManager share] clearMobileCacheWithViewController:self withBlock:^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
        }];
    }
    else if (indexPath.row == 2)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@",XY_AppleStore_Appid]]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Anno750(88);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5f;
}

- (void)createBottomView
{
    UIButton *loginOutButton = [JSFactory creatButtonWithTitle:@"退出登录" textFont:font750(36) titleColor:Color_Blue_32A060 backGroundColor:Color_Ground_FAFAFA];
    [JSFactory configureWithView:loginOutButton cornerRadius:Anno750(6) isBorder:YES borderWidth:0.5 borderColor:Color_Blue_32A060];
    [self.view addSubview:loginOutButton];
    [[loginOutButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[UserManager share] getLoginOut];
//        [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
    }];
    [loginOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(75)));
        make.right.equalTo(@(-Anno750(75)));
        make.bottom.equalTo(@(-Anno750(100)));
        make.height.equalTo(@(Anno750(110)));
    }];
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
