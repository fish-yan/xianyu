//
//  BJStoreListViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BJStoreListViewController.h"
#import "BJStoreListCell.h"

@interface BJStoreListViewController ()
@property (strong, nonatomic) BMStoreManagerVM *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BMStoreManagerModel *selectModel;
@end

@implementation BJStoreListViewController

- (BMStoreManagerVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BMStoreManagerVM alloc]init];
    }
    return _viewModel;
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
}

- (void)request {
    __block typeof(self) weakSelf = self;
    [self.viewModel requestStoreList:^(BOOL success) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// MARK: - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BJStoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BJStoreListCell" forIndexPath:indexPath];
    BMStoreManagerModel *model = self.viewModel.dataSource[indexPath.row];
    cell.titleLab.text = model.shopname;
    cell.desLab.text = model.address;
    cell.rightImg.hidden = ![model isEqual:self.selectModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectModel = self.viewModel.dataSource[indexPath.row];
    [self.tableView reloadData];
    !self.complete ?: self.complete(self.selectModel);
    [self.navigationController popViewControllerAnimated:YES];
}


@end
