//
//  CMWorkExpViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/26.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "CMWorkExpViewController.h"
#import "LTCell.h"
#import "CMJobTypeViewController.h"
#import "BRTFViewController.h"
#import "XianYu-Swift.h"

@interface CMWorkExpViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *tv;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end

@implementation CMWorkExpViewController

- (CMWorkExpVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CMWorkExpVM alloc]init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registCell];
    [self configView];
}

- (void)configView {
    self.tv.text = self.viewModel.model.jobdescribe;
    self.placeholderLab.hidden = self.tv.text.length != 0;
    self.countLab.text = [NSString stringWithFormat:@"%ld/500", self.tv.text.length];
}

- (void)registCell {
    [self.tableView registerNib:[UINib nibWithNibName:LTCELL bundle:nil] forCellReuseIdentifier:LTCELL];
}

- (IBAction)commitAction:(UIButton *)sender {
    __block typeof(self) weakSelf = self;
    [self.viewModel requestSaveWorkExp:^(BOOL success) {
        !weakSelf.complete ?: weakSelf.complete(weakSelf.viewModel.model);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (IBAction)deleteAction:(UIBarButtonItem *)sender {
    __block typeof(self) weakSelf = self;
    [self.viewModel requestDeleteWorkExp:^(BOOL success) {
        !weakSelf.complete ?: weakSelf.complete(nil);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
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
            self.viewModel.model.jobType = @"全职";
            [self.tableView reloadData];
        }];
        action.headTitle = @"求职类型";
        action.selectTitle = self.viewModel.type.des;
    } else if ([model isEqual:self.viewModel.position]) {
        [BRTFViewController start:@"工作职位" detail:self.viewModel.position.des des:@"" placeholder:@"填写工作职位" complete:^(NSString * _Nonnull text) {
            self.viewModel.position.des = text;
            self.viewModel.model.jobposition = text;
            [self.tableView reloadData];
        }];
    } else if ([model isEqual:self.viewModel.company]) {
        [BRTFViewController start:@"所在公司" detail:self.viewModel.company.des des:@"" placeholder:@"填写公司名称" complete:^(NSString * _Nonnull text) {
            self.viewModel.company.des = text;
            self.viewModel.model.shopname = text;
            [self.tableView reloadData];
        }];
    } else if ([model isEqual:self.viewModel.startDate]) {
        XYAlertDatePickerView *datePicker = [XYAlertDatePickerView ShowAlertDatePickerWithNameStr:@"开始时间" withViewController:self withSureBlock:^(id returnData) {
            self.viewModel.startDate.des = returnData;
            self.viewModel.model.startdate = returnData;
            [self.tableView reloadData];
        }];
        datePicker.datePicker.maximumDate = [NSDate date];
    } else if ([model isEqual:self.viewModel.endDate]) {
        XYAlertDatePickerView *datePicker = [XYAlertDatePickerView ShowAlertDatePickerWithNameStr:@"结束时间" withViewController:self withSureBlock:^(id returnData) {
            self.viewModel.endDate.des = returnData;
            self.viewModel.model.enddate = returnData;
            [self.tableView reloadData];
        }];
        datePicker.datePicker.maximumDate = [NSDate date];
    } else if ([model isEqual:self.viewModel.address]) {
        FYAddressPickerView *add = [FYAddressPickerView showWithComplete:^(FYAddressModel * _Nonnull add) {
            self.viewModel.address.des = [NSString stringWithFormat:@"%@-%@",add.province, add.city];
            self.viewModel.model.provincecode = add.proCode;
            self.viewModel.model.citycode = add.cityCode;
            [self.tableView reloadData];
        }];
        add.comp = 2;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView {
    self.viewModel.model.jobdescribe = textView.text;
    self.placeholderLab.hidden = self.tv.text.length != 0;
    self.countLab.text = [NSString stringWithFormat:@"%ld/500", self.tv.text.length];
}

@end
