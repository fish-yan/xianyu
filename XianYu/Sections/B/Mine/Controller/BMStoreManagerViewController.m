//
//  BMStoreManagerViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BMStoreManagerViewController.h"
#import "BMStoreManagerCell.h"
#import "BRStoreInfoViewController.h"
#import "BMStoreManagerVM.h"

@interface BMStoreManagerViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *errorV;
@property (strong, nonatomic) BMStoreManagerVM *viewModel;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) BOOL allAuth;
@end

@implementation BMStoreManagerViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginRefreshing) name:notification_reload_store_list object:nil];
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}


- (void)updataMsgLabel {
    self.allAuth = YES;
    for (BMStoreManagerModel *model in self.viewModel.dataSource) {
        if ([model.auditstatus isEqualToString:@"0"]) {
            self.allAuth = NO;
            break;
        }
    }
    self.errorV.hidden = self.allAuth;
}

- (void)request {
    __block typeof(self) weakSelf = self;
    [self.viewModel requestStoreList:^(BOOL success) {
        if (success && weakSelf.viewModel.dataSource.count > 0) {
            [CommanTool removeViewType:4 parentView:self.view];
            [CommanTool removeViewType:4 parentView:self.tableView];
        } else {
            [CommanTool removeViewType:4 parentView:self.view];
            [CommanTool removeViewType:4 parentView:self.tableView];
            [CommanTool addNoDataView:self.tableView withImage:@"icon_no_data" contentStr:@"暂无内容"];
        }
        [weakSelf.tableView.mj_header endRefreshing];
        if (weakSelf.viewModel.dataSource.count == weakSelf.viewModel.total) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf updataMsgLabel];
        [weakSelf.tableView reloadData];
    }];
}

- (IBAction)addStoreAction:(UIButton *)sender {
    if (self.allAuth) {
        self.type = 0;
        [self performSegueWithIdentifier:@"BRStoreInfo" sender:nil];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BRStoreInfo"]) {
        BRStoreInfoViewController *vc = segue.destinationViewController;
        vc.viewModel.fromeType = self.type;
        if ([sender isKindOfClass:[BMStoreManagerModel class]]) {
            vc.viewModel.storeInfo.id = ((BMStoreManagerModel *)sender).id;
        }
    }
}


// MARK: - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMStoreManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMStoreManagerCell" forIndexPath:indexPath];
    __block BMStoreManagerModel *model = self.viewModel.dataSource[indexPath.row];
    cell.model = model;
    cell.btnAction = ^(UIButton * _Nonnull btn) {
        self.type = 1;
        [self performSegueWithIdentifier:@"BRStoreInfo" sender:model];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BMStoreManagerModel *model = self.viewModel.dataSource[indexPath.row];
    self.type = 1;
    [self performSegueWithIdentifier:@"BRStoreInfo" sender:model];
}


@end
