//
//  BRAddressSelectorViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRAddressSelectorViewController.h"
#import "BRAddressCell.h"
#import "BRAddressSelectorVM.h"
#import "BRAddressDetailViewController.h"

@interface BRAddressSelectorViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) BRAddressSelectorVM *viewModel;

@end

@implementation BRAddressSelectorViewController

- (BRAddressSelectorVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BRAddressSelectorVM alloc]init];
    }
    return _viewModel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommanTool addLoadView:self.view];
    __block typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.viewModel.pageNum = 1;
        [weakSelf request];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.viewModel.pageNum += 1;
        [weakSelf request];
    }];
    [self.tableView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginRefreshing) name:notification_reload_address_list object:nil];
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}


- (void)request {
    __block typeof(self) weakSelf = self;
    [self.viewModel requestAddressList:^(BOOL success) {
        if (success) {
            [CommanTool removeViewType:4 parentView:self.view];
            [CommanTool removeViewType:4 parentView:self.tableView];
        } else {
            [CommanTool removeViewType:4 parentView:self.view];
            [CommanTool removeViewType:4 parentView:self.tableView];
            [CommanTool addNoDataView:self.tableView withImage:@"icon_no_data" contentStr:@"暂无内容"];
        }
        [weakSelf.tableView.mj_header endRefreshing];
        if (weakSelf.viewModel.total == weakSelf.viewModel.dataSource.count) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf.tableView reloadData];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BRAddressDetail"]) {
        BRAddressDetailViewController *vc = segue.destinationViewController;
        if ([sender isKindOfClass:[BRAddressModel class]]) {
            vc.viewModel.model = (BRAddressModel *)sender;
        }
    }
}


// MARK: - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BRAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BRAddressCell" forIndexPath:indexPath];
    __block BRAddressModel *model = self.viewModel.dataSource[indexPath.row];
    cell.titleLab.text = [NSString stringWithFormat:@"%@%@", model.pname, model.address];
    cell.editorAction = ^(UIButton * _Nonnull sender) {
        [self performSegueWithIdentifier:@"BRAddressDetail" sender:model];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BRAddressModel *model = self.viewModel.dataSource[indexPath.row];
    !self.complete ?: self.complete(model);
    [self.navigationController popViewControllerAnimated:YES];
}




@end
