//
//  C_Mine_ResumeViewController.m
//  XianYu
//
//  Created by lmh on 2019/7/7.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_ResumeViewController.h"
#import "C_Mine_ResumeInfoCell.h"
#import "C_Mine_ResumeStatusCell.h"
#import "C_Mine_ResumeWantJobCell.h"
#import "C_Mine_EditInfoViewController.h"
#import "C_Mine_WantJobViewController.h"
#import "C_Mine_Resume_ExperienceCell.h"
#import "C_Mine_Resume_AddExperienceCell.h"
#import "C_Mine_ResumeModel.h"
#import "C_Mine_Resume_JobExpModel.h"
#import "C_Mine_JobExperienceViewController.h"

@interface C_Mine_ResumeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) C_Mine_ResumeModel *currentModel;

@end

@implementation C_Mine_ResumeViewController

- (C_Mine_ResumeModel *)currentModel
{
    if (!_currentModel) {
        self.currentModel = [[C_Mine_ResumeModel alloc]init];
    }
    return _currentModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"我的简历" titleColor:Color_Black_323232 andNavColor:Color_White];
    [self drawBackButtonWithBlackStatus:(NavigationBackType_Black)];
    [self loadResumeData];
    [self createUI];
    
    // Do any additional setup after loading the view.
}

- (void)createUI{
    self.tableView = [JSFactory creatTabbleViewWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight)) style:(UITableViewStylePlain)];
//    self.tableView registerNib:<#(nullable UINib *)#> forCellReuseIdentifier:<#(nonnull NSString *)#>
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return 1;
    }
    else if (section == 2)
    {
        return 1;
    }
    else
    {
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier_info = @"infoCell";
        C_Mine_ResumeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_info];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"C_Mine_ResumeInfoCell" owner:self options:nil].firstObject;
        }
        [cell configureWithModel:self.currentModel];
        return cell;
    }
    else if(indexPath.section == 1)
    {
        static NSString *identifier_status = @"statusCell";
        C_Mine_ResumeStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_status];
        if (!cell) {
            cell = [[C_Mine_ResumeStatusCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_status];
        }
//        if (<#condition#>) {
//            <#statements#>
//        }
        return cell;
    }
    else if (indexPath.section == 2)
    {
        static NSString *identifier_want = @"wantCell";
        C_Mine_ResumeWantJobCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_want];
        if (!cell) {
            cell = [[C_Mine_ResumeWantJobCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_want];
        }
//        cell.jobTypeLabel.text =self.currentModel;
//        cell.jobCityLabel.text = self.currentModel.jobaddress;

        return cell;
    }
    else
    {
        if (indexPath.row < 4) {
            static NSString *identifier_experience = @"experienceCell";
            C_Mine_Resume_ExperienceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_experience];
            if (!cell) {
                cell = [[C_Mine_Resume_ExperienceCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_experience];
            }
            [cell configureWithModel:nil];
            return cell;
        }
        else
        {
            static NSString *identifier_add = @"addCell";
            C_Mine_Resume_AddExperienceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_add];
            if (!cell) {
                cell = [[C_Mine_Resume_AddExperienceCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier_add];
            }
//            [cell configureWithModel:nil];
            return cell;
        }
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        if (indexPath.row == 4) {
            C_Mine_JobExperienceViewController *VC = [C_Mine_JobExperienceViewController new];
            [self createViewWithController:VC andNavType:YES andLoginType:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return Anno750(348);
    }
    else if (indexPath.section == 1)
    {
        return Anno750(85);
    }
    else if (indexPath.section == 2)
    {
        return Anno750(320);
    }
    else
    {
        return Anno750(212);
    }
}


- (void)loadResumeData
{
    NSDictionary *params = @{};
    [[NetworkManager instance] sendReq:params pageUrl:XY_C_ResumeInfoData urlVersion:nil endLoad:YES viewController:self complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
            NSDictionary *dict = [result[@"data"] firstObject];
            C_Mine_ResumeModel *model = [[C_Mine_ResumeModel alloc]initWithModelDict:dict];
            self.currentModel = model;
            NSArray *array = dict[@"jexps"];
            NSMutableArray *mArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                C_Mine_Resume_JobExpModel *model = [[C_Mine_Resume_JobExpModel alloc]initWithModelDict:dic];
                [mArray addObject:model];
            }
            self.currentModel.jexps = mArray;
            [self.tableView reloadData];
        }
        else
        {
            [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
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
