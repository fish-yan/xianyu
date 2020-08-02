//
//  BResumeListViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BResumeListViewController.h"
#import "BResumeListCell.h"
#import "BResumeListVM.h"
#import "BResumeDetailViewController.h"

@interface BResumeListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgs;
@property (strong, nonatomic) BResumeListVM *viewModel;
@end

@implementation BResumeListViewController

- (BResumeListVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BResumeListVM alloc]init];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginRefreshing) name:notification_reload_resume_list object:nil];
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}


- (void)request {
    __block typeof(self) weakSelf = self;
    [self.viewModel requestResumeList:^(BOOL success) {
        if (success && weakSelf.viewModel.dataSource.count > 0) {
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

- (IBAction)typeAction:(UIButton *)sender {
    self.typeBtn.selected = YES;
    self.top.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
        self.bgView.alpha = 1;
    }];
}
- (IBAction)btnAction:(UIButton *)sender {
    for (UIButton *btn in self.btns) {
        btn.selected = btn.tag == sender.tag;
    }
    for (UIImageView *imgv in self.imgs) {
        imgv.hidden = imgv.tag != sender.tag;
    }
    [self.typeBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    if ([self.typeBtn.titleLabel.text isEqualToString:@"全部"]) {
        self.viewModel.shopsee = @"3";
    } else if ([self.typeBtn.titleLabel.text isEqualToString:@"已查看"]) {
        self.viewModel.shopsee = @"1";
    } else if ([self.typeBtn.titleLabel.text isEqualToString:@"未查看"]) {
        self.viewModel.shopsee = @"0";
    }
    [self request];
    self.typeBtn.selected = NO;
    self.top.constant = -130;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
        self.bgView.alpha = 0;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches.anyObject.view isEqual:self.bgView]) {
        self.typeBtn.selected = NO;
        self.top.constant = -130;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
            self.bgView.alpha = 0;
        }];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BResumeDetail"]) {
        BResumeDetailViewController *vc = segue.destinationViewController;
        if ([sender isKindOfClass:[BResumeModel class]]) {
            vc.resumeId = ((BResumeModel *)sender).id;
        }
        
    }
}


// MARK: - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BResumeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BResumeListCell" forIndexPath:indexPath];
    BResumeModel *model = self.viewModel.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BResumeModel *model = self.viewModel.dataSource[indexPath.row];
    [self performSegueWithIdentifier:@"BResumeDetail" sender:model];
}

@end
