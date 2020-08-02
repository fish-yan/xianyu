//
//  BJobListViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BJobListViewController.h"
#import "BJobListCell.h"
#import "BJobListVM.h"
#import "BJobDetailViewController.h"
#import "BJobPriceViewController.h"

//#import <RPSDK/RPSDK.h>

#import "BPostJobViewController.h"
#import "XianYu-Swift.h"


@interface BJobListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BJobListVM *viewModel;

@end

@implementation BJobListViewController

- (BJobListVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BJobListVM alloc]init];
    }
    return _viewModel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.hidden = self.viewModel.dataSource.count == 0;
    [self.navigationController setNavigationBarHidden:self.viewModel.dataSource.count == 0 animated:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [CommanTool addLoadView:self.view];
    self.tableView.hidden = true;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginRefreshing) name:notification_reload_job_list object:nil];
    [UserManager.share judgeLocationWithBlock:^(BOOL result) {
        if (result) {
            [UserManager.share configureWithLocationWithBlock:^{
                
            }];
        }
    }];
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}

- (void)request {
    __block typeof(self) weakSelf = self;
    [self.viewModel requestJobList:^(BOOL success) {
        [CommanTool removeViewType:4 parentView:self.view];
        [weakSelf.tableView.mj_header endRefreshing];
        if (weakSelf.viewModel.total == weakSelf.viewModel.dataSource.count) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf.tableView reloadData];
        if (weakSelf.viewModel.dataSource.count != 0) {
            weakSelf.tableView.hidden = NO;
            [weakSelf.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }];
}
- (IBAction)postJobAction:(id)sender {
    XYActionSheetViewController *action = [XYActionSheetViewController show:@[@"全职", @"兼职"] complete:^(NSString * _Nonnull title) {
        [self performSegueWithIdentifier:@"BPostJob" sender:title];
    }];
    action.headTitle = @"发布职位";
}

- (void)cellBtnAction:(BJobModel *)model sender:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"重新上线"]) {
        [BJobListVM requestChangeStatus:model.id type:model.jobtype status:@"1" complete:^(BOOL success) {
            [self.tableView reloadData];
        }];
    } else if ([sender.titleLabel.text isEqualToString:@"分享"]) {
        [UserManager.share shareToWX:model.jobtype jobId:model.id];
    } else if ([sender.titleLabel.text isEqualToString:@"下线"]) {
        [BJobListVM requestChangeStatus:model.id type:model.jobtype status:@"0" complete:^(BOOL success) {
            [self.tableView reloadData];
        }];
    } else if ([sender.titleLabel.text isEqualToString:@"续费上线"]) {
        [self performSegueWithIdentifier:@"BJobPrice" sender:model];
    } else if ([sender.titleLabel.text isEqualToString:@"马上开放"]) {
        if ([model.status isEqualToString:@"3"]) { //未买过套餐
            [self performSegueWithIdentifier:@"BJobPrice" sender:model];
        } else if ([model.status isEqualToString:@"4"]) {//买过套餐并在使用期内但是店家未个人认证
            [UserManager.share requestAuth:^(NSString * _Nonnull token, NSString * _Nonnull ticketid, FaceCallBack  _Nonnull faceCallBack) {
                [UserManager start:token rpCompleted:^(AUDIT auditState) {
                    faceCallBack();
                }withVC:self.navigationController];
            } complete:^{
                [self.tableView.mj_header beginRefreshing];
            }];
        }
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BPostJob"]) {
        BPostJobViewController *vc = segue.destinationViewController;
        vc.viewModel.type = [(NSString *)sender isEqualToString:@"全职"] ? 0 : 1;
    } else if ([segue.identifier isEqualToString:@"BJobDetail"]) {
        BJobDetailViewController *vc = segue.destinationViewController;
        if ([sender isKindOfClass:[BJobModel class]]) {
            BJobModel *model = sender;
            vc.type = [model.jobtype integerValue];
            vc.jobId = model.id;
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BJobListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BJobListCell" forIndexPath:indexPath];
    __block BJobModel *model = self.viewModel.dataSource[indexPath.row];
    cell.model = model;
    cell.btnAction = ^(UIButton * _Nonnull btn) {
        [self cellBtnAction:model sender:btn];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 133;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BJobModel *model = self.viewModel.dataSource[indexPath.row];
    [self performSegueWithIdentifier:@"BJobDetail" sender:model];
}

@end
