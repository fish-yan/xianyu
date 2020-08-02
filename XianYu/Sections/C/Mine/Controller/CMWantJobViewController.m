//
//  CMWantJobViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/26.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "CMWantJobViewController.h"

#import "LTCell.h"
#import "CMJobTypeViewController.h"
#import "XianYu-Swift.h"

@interface CMWantJobViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CMWantJobViewController

- (CMWantJobVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CMWantJobVM alloc]init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registCell];
    
}

- (void)registCell {
    [self.tableView registerNib:[UINib nibWithNibName:LTCELL bundle:nil] forCellReuseIdentifier:LTCELL];
}

- (IBAction)commitAction:(UIButton *)sender {
    !self.complete ?: self.complete(self.viewModel.model);
    [self.navigationController popViewControllerAnimated:YES];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"CMJobType"]) {
         CMJobTypeViewController *vc = segue.destinationViewController;
         NSMutableArray *arr = [NSMutableArray array];
         for (NSString *str in [self.viewModel.model.wantjob componentsSeparatedByString:@"&"]) {
             BResumeModel *m = [[BResumeModel alloc]init];
             m.name = str;
             m.id = str;
             [arr addObject:m];
         }
         vc.selectedArr = arr;
         vc.type = [self.viewModel.model.jobtype integerValue];
         vc.complete = ^(NSArray<JobDetailModel *> * _Nonnull selectedArr) {
             NSMutableArray *nameArr = [NSMutableArray array];
             NSMutableArray *idArr = [NSMutableArray array];
             for (JobDetailModel *m in selectedArr) {
                 [nameArr addObject:m.name];
                 [idArr addObject:m.id];
             }
             self.viewModel.position.des = [nameArr componentsJoinedByString:@"&"];
             self.viewModel.model.wantjob = [nameArr componentsJoinedByString:@"&"];
             [self.tableView reloadData];
         };
     }
 }


// MARK: - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTCellModel *model = self.viewModel.dataSource[indexPath.row];
        LTCell *cell = [tableView dequeueReusableCellWithIdentifier:LTCELL forIndexPath:indexPath];
    cell.model = model;
        return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LTCellModel *model = self.viewModel.dataSource[indexPath.row];
    if ([model isEqual:self.viewModel.type]) {
        XYActionSheetViewController *action = [XYActionSheetViewController show: @[@"全职", @"兼职"] complete:^(NSString * _Nonnull title) {
            self.viewModel.type.des = title;
            self.viewModel.model.jobtype = [title isEqualToString:@"全职"] ? @"0" : @"1";
            [self.viewModel configCells];
            [self.tableView reloadData];
        }];
        action.headTitle = @"求职类型";
        action.selectTitle = self.viewModel.type.des;
    } else if ([model isEqual:self.viewModel.address]) {
        FYAddressPickerView *addressPicker = [FYAddressPickerView showWithComplete:^(FYAddressModel * _Nonnull add) {
            self.viewModel.address.des = [NSString stringWithFormat:@"%@%@", add.province, add.city];
            self.viewModel.model.jobaddress = [NSString stringWithFormat:@"%@%@", add.province, add.city];
            [self.tableView reloadData];
        }];
        addressPicker.comp = 2;
    } else if ([model isEqual:self.viewModel.fullMoney]) {
        XYDobuleASViewController *action = [XYDobuleASViewController show:xy_moeny_min secArr:xy_moeny_max complete:^(NSNumber * _Nonnull first, NSNumber * _Nonnull second) {
            self.viewModel.fullMoney.des = [NSString stringWithFormat:@"%@-%@元", first, second];
            self.viewModel.model.wantwage = [NSString stringWithFormat:@"%@-%@元", first, second];
            [self.tableView reloadData];
        }];
        action.headTitle = @"期望薪资";
        action.unit = @"元";
        action.selectUnit = @"/月";
        NSArray *arr = [[self.viewModel.fullMoney.des stringByReplacingOccurrencesOfString:@"元" withString:@""] componentsSeparatedByString:@"-"];
        if (arr.count > 1) {
            action.first = [NSNumber numberWithInteger:[arr[0] integerValue]];
            action.second = [NSNumber numberWithInteger:[arr[1] integerValue]];
        }
    } else if ([model isEqual:self.viewModel.partMoney]) {
        XYDobuleASViewController *action = [XYDobuleASViewController show:xy_part_moeny_min secArr:xy_part_moeny_max complete:^(NSNumber * _Nonnull first, NSNumber * _Nonnull second) {
            self.viewModel.partMoney.des = [NSString stringWithFormat:@"%@-%@元", first, second];
            self.viewModel.model.dailywage = [NSString stringWithFormat:@"%@-%@元", first, second];
            [self.tableView reloadData];
        }];
        action.headTitle = @"期望日薪";
        action.unit = @"元";
        action.selectUnit = @"/日";
        NSArray *arr = [[self.viewModel.partMoney.des stringByReplacingOccurrencesOfString:@"元" withString:@""] componentsSeparatedByString:@"-"];
        if (arr.count > 1) {
            action.first = [NSNumber numberWithInteger:[arr[0] integerValue]];
            action.second = [NSNumber numberWithInteger:[arr[1] integerValue]];
        }
    } else if ([model isEqual:self.viewModel.position]) {
        [self performSegueWithIdentifier:@"CMJobType" sender:nil];
    } else if ([model isEqual:self.viewModel.freeTime]) {
        XYActionSheetViewController *action = [XYActionSheetViewController show:xy_free_time complete:^(NSString * _Nonnull title) {
            self.viewModel.freeTime.des = title;
            self.viewModel.model.freetime = title;
            [self.tableView reloadData];
        }];
        action.headTitle = @"空闲时间";
    }
}


@end
