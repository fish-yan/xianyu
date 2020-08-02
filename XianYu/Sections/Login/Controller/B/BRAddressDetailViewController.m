//
//  BRAddressDetailViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRAddressDetailViewController.h"
#import "LTCell.h"

#import "XianYu-Swift.h"

@interface BRAddressDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet UITextView *addressDetailTV;
@end

@implementation BRAddressDetailViewController

- (BRAddressDetailVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BRAddressDetailVM alloc]init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registCell];
    self.viewModel.add.des = self.viewModel.model.pname;
    self.addressDetailTV.text = self.viewModel.model.address;
    self.placeholder.hidden = self.addressDetailTV.text.length != 0;
}

- (void)registCell {
    [self.tableView registerNib:[UINib nibWithNibName:LTCELL bundle:nil] forCellReuseIdentifier:LTCELL];
}

- (IBAction)commitAction:(UIButton *)sender {
    [self.view endEditing:YES];
    __block typeof(self) weakSelf = self;
    [self.viewModel requestAddAddress:^(BOOL success) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notification_reload_address_list object:nil];
        [weakSelf.navigationController popViewControllerAnimated:YES];
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

// UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTCell *cell = [tableView dequeueReusableCellWithIdentifier:LTCELL forIndexPath:indexPath];
    cell.model = self.viewModel.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LTCellModel *model = self.viewModel.dataSource[indexPath.row];
    if ([model isEqual:self.viewModel.add]) {
        (void)[FYAddressPickerView showWithComplete:^(FYAddressModel * _Nonnull address) {
            self.viewModel.model.pname = [NSString stringWithFormat:@"%@%@%@", address.province, address.city, address.area];
            self.viewModel.add.des = self.viewModel.model.pname;
            self.viewModel.model.provincecode = address.proCode;
            self.viewModel.model.citycode = address.cityCode;
            self.viewModel.model.towncode = address.areaCode;
            [self.tableView reloadData];
        }];
        
//        FYAddressPickerView *add = [FYAddressPickerView showWithComplete:^(FYAddressModel * _Nonnull add) {
//        }];
    }
}


// MARK: - UITextView
- (void)textViewDidChange:(UITextView *)textView {
    self.placeholder.hidden = textView.text.length != 0;
    self.viewModel.model.address = textView.text;
}

@end
