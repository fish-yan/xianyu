//
//  BRStoreInfoViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRStoreInfoViewController.h"
#import "LTCell.h"
#import "XYActionSheetViewController.h"
#import "XYConstUtils.h"
#import "BRTradeSelectorViewController.h"
#import "BRTFViewController.h"
#import "BRAddressSelectorViewController.h"
#import "BRStoreDesViewController.h"
#import "BRPositionDetailViewController.h"
#import "BRStoreLicenseViewController.h"
#import "BRBranchStoreNameViewController.h"
#import "BRPhotoCell.h"
#import "C_Mine_EditFooterView.h"
#import "XYPickPhotoUtils.h"

@interface BRStoreInfoViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) C_Mine_EditFooterView *footerView;

@property (nonatomic, strong) NSMutableDictionary *tempDict;

@end

@implementation BRStoreInfoViewController

- (BRStoreInfoVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BRStoreInfoVM alloc]init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tempDict = [NSMutableDictionary dictionary];
    [self registCell];
    [self request];
    if (self.viewModel.fromeType == 1) {
        [self configFooterView];
    }
    if (self.viewModel.fromeType == 2) {
        [self configFooterView];
        self.footerView.userInteractionEnabled = NO;
        self.commitBtn.hidden = YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(request) name:notification_reload_store_info object:nil];
}

- (void)configFooterView {
    NSInteger count = 4;
    CGFloat width = (KScreenWidth - 24 - (count - 1) * 10)/count;
    CGFloat height = width * 9 / 11 + 40;
    self.footerView = [[C_Mine_EditFooterView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, height)];
    [self.tableView.tableFooterView addSubview:self.footerView];
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, KScreenWidth, height + 120);
    self.footerView.imgCount = count;
    if (self.viewModel.imgs.count > 0) {
        self.footerView.img1 = self.viewModel.imgs[0];
    }
    if (self.viewModel.imgs.count > 1) {
        self.footerView.img2 = self.viewModel.imgs[1];
    }
    if (self.viewModel.imgs.count > 2) {
        self.footerView.img3 = self.viewModel.imgs[2];
    }
    if (self.viewModel.imgs.count > 3) {
        self.footerView.img4 = self.viewModel.imgs[3];
    }
    [self.footerView configImgs];
    __block typeof(self) weakSelf = self;
    self.footerView.complete = ^(NSString * _Nonnull imgStr, NSInteger tag) {
        NSString *key = [NSString stringWithFormat:@"%ld",tag];
        weakSelf.tempDict[key] = imgStr;
        weakSelf.viewModel.imgs = weakSelf.tempDict.allValues;
    };
}


- (void)request {
    __block typeof(self) weakSelf = self;
    if (self.viewModel.fromeType != 0) {
        [self.viewModel requestGetStoreInfo:^(BOOL success) {
            [weakSelf.tableView reloadData];
            [weakSelf configFooterView];
        }];
    }
}

- (void)registCell {
    [self.tableView registerNib:[UINib nibWithNibName:LTCELL bundle:nil] forCellReuseIdentifier:LTCELL];
}

- (IBAction)commitAction:(UIButton *)sender {
    [self.viewModel requestSaveStore:^(BOOL success) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notification_reload_store_list object:nil];
        !self.complete ?: self.complete(self.viewModel.storeNm.des);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BRAddressSelector"]) {
        BRAddressSelectorViewController *vc = segue.destinationViewController;
        vc.complete = ^(BRAddressModel * _Nonnull model) {
            self.viewModel.addressModel = model;
            self.viewModel.storeAdd.des = [NSString stringWithFormat:@"%@%@", model.pname, model.address];
            [self.tableView reloadData];
        };
    } else if ([segue.identifier isEqualToString:@"BRTradeSelector"]) {
        BRTradeSelectorViewController *vc = segue.destinationViewController;
        vc.selectModel = self.viewModel.tradeModel;
        vc.complete = ^(BRTradeModel * _Nonnull model) {
            self.viewModel.tradeModel = model;
            self.viewModel.trade.des = model.name;
            [self.tableView reloadData];
        };
    } else if ([segue.identifier isEqualToString:@"BRStoreDes"]) {
        BRStoreDesViewController *vc = segue.destinationViewController;
        vc.des = self.viewModel.storeDes.des;
        vc.complete = ^(NSString * _Nonnull name) {
            self.viewModel.storeDes.des = name;
            [self.tableView reloadData];
        };
    } else if ([segue.identifier isEqualToString:@"BRPositionDetail"]) {
        BRPositionDetailViewController *vc = segue.destinationViewController;
        vc.name = self.viewModel.myJob.des;
        vc.complete = ^(NSString * _Nonnull name) {
            self.viewModel.myJob.des = name;
            [self.tableView reloadData];
        };
    } else if ([segue.identifier isEqualToString:@"BRStoreLicense"]) {
        BRStoreLicenseViewController *vc = segue.destinationViewController;
        vc.shopId = self.viewModel.storeInfo.id;
    } else if ([segue.identifier isEqualToString:@"BRBranchStoreName"]) {
        BRBranchStoreNameViewController *vc = [segue destinationViewController];
        vc.complete = ^(NSString * _Nonnull name) {
            self.viewModel.branchStoreNm.des = name;
            [self.tableView reloadData];
        };
        vc.storeNm = self.viewModel.storeNm.des;
        vc.branchStoreNm = self.viewModel.branchStoreNm.des;
    }
}


// MARK: - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTCellModel *model = self.viewModel.dataSource[indexPath.row];
    if ([model isEqual:self.viewModel.photo]) {
        BRPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BRPhotoCell" forIndexPath:indexPath];
        cell.titleLab.text = model.title;
        cell.photo = model.des;
        return cell;
    } else {
        LTCell *cell = [tableView dequeueReusableCellWithIdentifier:LTCELL forIndexPath:indexPath];
        cell.model = self.viewModel.dataSource[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTCellModel *model = self.viewModel.dataSource[indexPath.row];
    if ([model isEqual: self.viewModel.photo]) {
        return 70;
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LTCellModel *model = self.viewModel.dataSource[indexPath.row];
    if (model.type == LTDisable) {
        return;
    }
    if ([model isEqual:self.viewModel.photo]) {
        [XYPickPhotoUtils pickPhoto:self complete:^(UIImage * _Nonnull img) {
            [OSSManager.share uploadImage:img withSize:CGSizeMake(100, 100) withBlock:^(id  _Nonnull result) {
                self.viewModel.photo.des = (NSString *)result;
//                self.viewModel.model.photourl = (NSString *)result;
                
            }];
        }];
    } else if ([model isEqual:self.viewModel.storeNm]) {
        [BRTFViewController start:@"门店名称" detail:self.viewModel.storeNm.des des:@"例如：海底捞" placeholder:@"请输入门店名称" complete:^(NSString * _Nonnull text) {
            self.viewModel.storeNm.des = text;
            [self.tableView reloadData];
        }];
    } else if ([model isEqual:self.viewModel.branchStoreNm]) {
        [self performSegueWithIdentifier:@"BRBranchStoreName" sender:nil];
    } else if ([model isEqual:self.viewModel.storeAdd]) {
        [self performSegueWithIdentifier:@"BRAddressSelector" sender:nil];
    } else if ([model isEqual:self.viewModel.employerCount]) {
        XYActionSheetViewController *action = [XYActionSheetViewController show: xy_employee complete:^(NSString * _Nonnull title) {
            self.viewModel.employerCount.des = title;
            [self.tableView reloadData];
        }];
        action.headTitle = @"人员规模";
        action.selectTitle = self.viewModel.employerCount.des;
    } else if ([model isEqual:self.viewModel.trade]) {
        [self performSegueWithIdentifier:@"BRTradeSelector" sender:nil];
    } else if ([model isEqual:self.viewModel.storeDes]) {
        [self performSegueWithIdentifier:@"BRStoreDes" sender:nil];
    } else if ([model isEqual:self.viewModel.status]) {
        if (![self.viewModel.storeInfo.auditstatus isEqualToString:@"1"]) {
            [self performSegueWithIdentifier:@"BRStoreLicense" sender:nil];
        }
    } else if ([model isEqual:self.viewModel.myJob]) {
        [self performSegueWithIdentifier:@"BRPositionDetail" sender:nil];
    }
}



@end
