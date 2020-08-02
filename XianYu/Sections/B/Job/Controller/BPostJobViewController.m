//
//  BPostJobViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BPostJobViewController.h"

#import "LTCell.h"
#import "BPositionListViewController.h"
#import "BPaymentViewController.h"
#import "XYConstUtils.h"
#import "BRTFViewController.h"
#import "BBenefitViewController.h"
#import "BJStoreListViewController.h"
#import "BJobDesViewController.h"
#import "BJDateViewController.h"
#import "BJobDetailViewController.h"
#import "XianYu-Swift.h"

@interface BPostJobViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BPostJobViewController

- (BPostJobVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BPostJobVM alloc]init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.viewModel.type == 0 ? @"发布全职职位" : @"发布兼职职位";
    [self registCell];
}

- (void)registCell {
    [self.tableView registerNib:[UINib nibWithNibName:LTCELL bundle:nil] forCellReuseIdentifier:LTCELL];
}

- (IBAction)commitAction:(UIButton *)sender {
    __block typeof(self) weakSelf = self;
    [self.viewModel requestSaveJob:^(BOOL success) {
        BJobDetailViewController *detailVC = nil;
        for (UIViewController *c in self.navigationController.viewControllers) {
            if ([c isKindOfClass:[BJobDetailViewController class]]) {
                detailVC = (BJobDetailViewController *)c;
            }
        }
        if (detailVC) {
            [weakSelf.navigationController popToViewController:detailVC animated:YES];
        } else {
            [weakSelf performSegueWithIdentifier:@"BJobDetail" sender:nil];
        }
        NSMutableArray *arr = [NSMutableArray arrayWithArray:weakSelf.navigationController.viewControllers];
        [arr removeObject:weakSelf];
        self.navigationController.viewControllers = arr;
        [[NSNotificationCenter defaultCenter] postNotificationName:notification_reload_job_detail object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:notification_reload_job_list object:nil];
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BPositionList"]) {
        BPositionListViewController *vc = segue.destinationViewController;
        vc.type = self.viewModel.type;
        JobDetailModel *model = [[JobDetailModel alloc]init];
        model.id = self.viewModel.jobModel.classid;
        model.name = self.viewModel.jobModel.classname;
        vc.detailModel = model;
        vc.complete = ^(JobDetailModel * _Nonnull model) {
            self.viewModel.jobModel.classid = model.id;
            self.viewModel.jobModel.classname = model.name;
            self.viewModel.postion.des = model.name;
            [self.tableView reloadData];
        };
    } else if ([segue.identifier isEqualToString:@"BPayment"]) {
        BPaymentViewController *vc = segue.destinationViewController;
        NSString *m = self.viewModel.jobModel.wagedes;
        vc.money = [m substringToIndex:m.length - 3];
        vc.unit = [m substringFromIndex:m.length - 3];
        vc.type = self.viewModel.jobModel.wagetype;
        vc.complete = ^(NSString * _Nonnull money, NSString * _Nonnull unit, NSString * _Nonnull type) {
            self.viewModel.pay.des = [NSString stringWithFormat:@"%@%@",money, unit];
            self.viewModel.jobModel.wagedes = self.viewModel.pay.des ;
            self.viewModel.jobModel.wagetype = type;
            [self.tableView reloadData];
        };
    } else if ([segue.identifier isEqualToString:@"BBenefit"]) {
        BBenefitViewController *vc = segue.destinationViewController;
        vc.selected = self.viewModel.jobModel.welfarenew;
        vc.complete = ^(NSString * _Nonnull selected) {
            self.viewModel.benefit.des = selected;
            self.viewModel.jobModel.welfarenew = selected;
            [self.tableView reloadData];
        };
    } else if ([segue.identifier isEqualToString:@"BJStoreList"]) {
        BJStoreListViewController *vc = segue.destinationViewController;
        vc.complete = ^(BMStoreManagerModel * _Nonnull model) {
            self.viewModel.store.des = model.shopname;
            self.viewModel.jobModel.shopid = model.id;
            self.viewModel.address.des = model.address;
            [self.tableView reloadData];
        };
    } else if ([segue.identifier isEqualToString:@"BJobDes"]) {
        BJobDesViewController *vc = segue.destinationViewController;
        vc.positionId = self.viewModel.jobModel.classid ?: @"";
        vc.des = self.viewModel.jobModel.jobdesc;
        vc.complete = ^(NSString * _Nonnull name) {
            self.viewModel.des.des = name;
            self.viewModel.jobModel.jobdesc = name;
            [self.tableView reloadData];
        };
    } else if ([segue.identifier isEqualToString:@"BJDate"]) {
        BJDateViewController *vc = segue.destinationViewController;
        vc.date1Str = self.viewModel.jobModel.startDate;
        vc.date2Str = self.viewModel.jobModel.endDate;
        NSArray *times = [self.viewModel.jobModel.timeslot componentsSeparatedByString:@"-"];
        vc.time1Str = times[0];
        vc.time2Str = times[1];
        vc.complete = ^(NSString * _Nonnull date1, NSString * _Nonnull date2, NSString * _Nonnull time1, NSString * _Nonnull time2) {
            self.viewModel.workDate.des = [NSString stringWithFormat:@"%@-%@", date1, date2];
            self.viewModel.jobModel.startDate = date1;
            self.viewModel.jobModel.endDate = date2;
            self.viewModel.jobModel.timeslot = [NSString stringWithFormat:@"%@-%@",time1, time2];
            [self.tableView reloadData];
        };
    } else if ([segue.identifier isEqualToString:@"BJobDetail"]) {
        BJobDetailViewController *vc = segue.destinationViewController;
        vc.jobId = self.viewModel.jobModel.id;
        vc.type = self.viewModel.type;
    }
}


// MARK: - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource[section].count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LTCellModel *model = self.viewModel.dataSource[indexPath.section][indexPath.row];
    CGFloat left = [model isEqual:self.viewModel.store] ? 1000 : 0;
    cell.separatorInset = UIEdgeInsetsMake(0, left, 0, 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTCell *cell = [tableView dequeueReusableCellWithIdentifier:LTCELL forIndexPath:indexPath];
    cell.model = self.viewModel.dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 65)];
    v.backgroundColor = UIColor.whiteColor;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 100, 65)];
    lab.textColor = UIColorFromRGB(0x323232);
    lab.font = [UIFont systemFontOfSize:18 weight:(UIFontWeightMedium)];
    if (section == 0) {
        lab.text = @"职位描述";
    } else if (section == 1) {
        lab.text = @"职位要求";
    }
    [v addSubview:lab];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 65;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LTCellModel *model = self.viewModel.dataSource[indexPath.section][indexPath.row];
    if ([model isEqual:self.viewModel.postion]) {
        [self performSegueWithIdentifier:@"BPositionList" sender:nil];
    }
    if ([model isEqual:self.viewModel.postionNm]) {
        BRTFViewController *tfv = [BRTFViewController start:@"职位名称" detail:self.viewModel.postionNm.des des:@"" placeholder:@"请填写职位名称" complete:^(NSString * _Nonnull text) {
            self.viewModel.postionNm.des = text;
            self.viewModel.jobModel.jobname = text;
            [self.tableView reloadData];
        }];
        tfv.maxLen = 15;
    }else if ([model isEqual:self.viewModel.pay]) {
        if (self.viewModel.type == 0) {
            XYDobuleASViewController *action = [XYDobuleASViewController show:xy_moeny_min secArr:xy_moeny_max complete:^(NSNumber * _Nonnull first, NSNumber * _Nonnull second) {
                self.viewModel.pay.des = [NSString stringWithFormat:@"%@-%@元/月", first, second];
                self.viewModel.jobModel.wagedes = [NSString stringWithFormat:@"%@-%@", first, second];
                [self.tableView reloadData];
            }];
            NSArray *arr = [[self.viewModel.jobModel.wagedes stringByReplacingOccurrencesOfString:@"元/月" withString:@""] componentsSeparatedByString:@"-"];
            action.first = [NSNumber numberWithInteger:[arr.firstObject integerValue]];
            action.second = [NSNumber numberWithInteger:[arr[1] integerValue]];
            action.headTitle = @"结算薪资";
            action.selectUnit = @"元";
        } else {
            [self performSegueWithIdentifier:@"BPayment" sender:nil];
        }
    } else if ([model isEqual:self.viewModel.age]) {
        NSMutableArray *first = [NSMutableArray array];
        NSMutableArray *second = [NSMutableArray array];
        for (int i = 18; i < 100; i++) {
            [first addObject:[NSNumber numberWithInt:i]];
            [second addObject:[NSNumber numberWithInt:i+1]];
        }
        XYDobuleASViewController *action = [XYDobuleASViewController show:first secArr:second complete:^(NSNumber * _Nonnull first, NSNumber * _Nonnull second) {
            self.viewModel.age.des = [NSString stringWithFormat:@"%@-%@岁", first, second];
            self.viewModel.jobModel.age = [NSString stringWithFormat:@"%@-%@岁", first, second];
            [self.tableView reloadData];
        }];
        NSArray *arr = [[self.viewModel.jobModel.age stringByReplacingOccurrencesOfString:@"岁" withString:@""] componentsSeparatedByString:@"-"];
        action.first = [NSNumber numberWithInteger:[arr.firstObject integerValue]];
        action.second = [NSNumber numberWithInteger:[arr[1] integerValue]];
        action.headTitle = @"年龄要求";
        action.selectUnit = @"岁";
    } else if ([model isEqual:self.viewModel.degree]) {
        XYActionSheetViewController *action = [XYActionSheetViewController show:xy_degree complete:^(NSString * _Nonnull title) {
            self.viewModel.degree.des = title;
            self.viewModel.jobModel.education = [self.viewModel transEdu:title];
            self.viewModel.jobModel.educationname = title;
            [self.tableView reloadData];
        }];
        action.selectTitle = self.viewModel.jobModel.educationname;
        action.headTitle = @"学历要求";
    } else if ([model isEqual:self.viewModel.exp]) {
        XYActionSheetViewController *action = [XYActionSheetViewController show:xy_exp complete:^(NSString * _Nonnull title) {
            self.viewModel.exp.des = title;
            self.viewModel.jobModel.jobexp = title;
            [self.tableView reloadData];
        }];
        action.selectTitle = self.viewModel.jobModel.jobexp;
        action.headTitle = @"经验要求";
    } else if ([model isEqual:self.viewModel.benefit]) {
        [self performSegueWithIdentifier:@"BBenefit" sender:nil];
    } else if ([model isEqual:self.viewModel.store]) {
        [self performSegueWithIdentifier:@"BJStoreList" sender:nil];
    } else if ([model isEqual:self.viewModel.tel]) {
        BRTFViewController *tfv = [BRTFViewController start:@"联系电话" detail:self.viewModel.tel.des des:@"" placeholder:@"请填写联系电话" complete:^(NSString * _Nonnull text) {
            self.viewModel.tel.des = text;
            self.viewModel.jobModel.mobile = text;
            [self.tableView reloadData];
        }];
        tfv.keyboardType = UIKeyboardTypeNumberPad;
        tfv.maxLen = 11;
    } else if ([model isEqual:self.viewModel.des]) {
        [self performSegueWithIdentifier:@"BJobDes" sender:nil];
    } else if ([model isEqual:self.viewModel.workDate]) {
        [self performSegueWithIdentifier:@"BJDate" sender:nil];
    }
}


@end
