//
//  BRInfoViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRInfoViewController.h"

#import "LTCell.h"
#import "BRPhotoCell.h"
#import "XYPickPhotoUtils.h"
#import "XYActionSheetViewController.h"
#import "XYConstUtils.h"
#import "YSHYClipViewController.h"
#import "BRTFViewController.h"
#import "BRStoreInfoViewController.h"
#import "XianYu-Swift.h"
#import "BJobPriceViewController.h"

@interface BRInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BRInfoViewController

- (BRInfoVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BRInfoVM alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registCell];
    __block typeof(self) weakSelf = self;
    [self.viewModel requestGetMineInfo:^(BOOL success) {
        [weakSelf.tableView reloadData];
    }];
    if (self.viewModel.type == 1) {
        self.title = @"基本信息";
        self.tableView.tableFooterView.frame = CGRectZero;
    }
}

- (void)registCell {
    [self.tableView registerNib:[UINib nibWithNibName:LTCELL bundle:nil] forCellReuseIdentifier:LTCELL];
}

- (void)requestSave {
    __block typeof(self) weakSelf = self;
    if (self.viewModel.type == 0) {
        [weakSelf.tableView reloadData];
    } else {
        [self.viewModel requestSaveMinInfo:^(BOOL success) {
            [UserManager.share loadUserInfoData:XYB block:^(int code) {
            } withConnect:YES];
            [weakSelf.tableView reloadData];
        }];
    }
}

- (IBAction)commitAction:(UIButton *)sender {
    if (self.viewModel.type == 0) {
        [self.viewModel requestSaveMinInfo:^(BOOL success) {
            [UserManager.share loadUserInfoData:XYB block:^(int code) {
                if ([[UserManager share].infoModel.havepay isEqualToString:@"1"]) {
                    [UserManager.share switchClient:XYB complete:^{
                        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
                        UIApplication.sharedApplication.keyWindow.rootViewController = vc;
                    }];
                } else { // 去支付
                    BJobPriceViewController *vc = [[UIStoryboard storyboardWithName:@"BJob" bundle:nil] instantiateViewControllerWithIdentifier:@"BJobPriceViewController"];
                    vc.isFirst = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            } withConnect:YES];
        }];
    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BRStoreInfo"]) {
        BRStoreInfoViewController *vc = segue.destinationViewController;
        if (self.viewModel.storeManagerModel.id && self.viewModel.storeManagerModel.id.length != 0) {
            vc.viewModel.fromeType = 1;
            vc.viewModel.storeInfo.id = self.viewModel.storeManagerModel.id;
        } else {
            vc.viewModel.fromeType = 0;
        }
        vc.complete = ^(NSString * _Nonnull storeNm) {
            self.viewModel.store.des = storeNm;
            [self.tableView reloadData];
        };
    }
}



// MARK: - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTCellModel *model = self.viewModel.dataSource[indexPath.section][indexPath.row];
    if ([model isEqual:self.viewModel.photo]) {
        BRPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BRPhotoCell" forIndexPath:indexPath];
        cell.photo = model.des;
        return cell;
    } else {
        LTCell *cell = [tableView dequeueReusableCellWithIdentifier:LTCELL forIndexPath:indexPath];
        cell.model = self.viewModel.dataSource[indexPath.section][indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTCellModel *model = self.viewModel.dataSource[indexPath.section][indexPath.row];
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
    if (section == 0) {
        return 51;
    } else {
        return 0.01;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LTCellModel *model = self.viewModel.dataSource[indexPath.section][indexPath.row];
    if ([model isEqual:self.viewModel.photo]) {
        [XYPickPhotoUtils pickPhoto:self complete:^(UIImage * _Nonnull img) {
            [OSSManager.share uploadImage:img withSize:CGSizeMake(100, 100) withBlock:^(id  _Nonnull result) {
                self.viewModel.photo.des = (NSString *)result;
                self.viewModel.model.photourl = (NSString *)result;
                [self requestSave];
            }];
        }];
    } else if ([model isEqual:self.viewModel.name]) {
        [BRTFViewController start:@"姓名" detail:self.viewModel.name.des des:@"" placeholder:@"请填写姓名" complete:^(NSString * _Nonnull text) {
            self.viewModel.name.des = text;
            self.viewModel.model.name = text;
            [self requestSave];
        }];
    } else if ([model isEqual:self.viewModel.sex]) {
        XYActionSheetViewController *action = [XYActionSheetViewController show: xy_sex complete:^(NSString * _Nonnull title) {
            self.viewModel.sex.des = title;
            self.viewModel.model.sex = title;
            [self requestSave];
        }];
        action.headTitle = @"性别";
        action.selectTitle = self.viewModel.sex.des;
    } else if ([model isEqual:self.viewModel.store]) {
        __block typeof(self) weakSelf = self;
        [self.viewModel requestStoreList:^(BOOL success) {
            [weakSelf performSegueWithIdentifier:@"BRStoreInfo" sender:nil];
        }];
        
    } else if ([model isEqual:self.viewModel.tel]) {
        BRTFViewController *tf = [BRTFViewController start:@"手机号" detail:self.viewModel.tel.des des:@"" placeholder:@"请填写手机号" complete:^(NSString * _Nonnull text) {
            self.viewModel.tel.des = text;
            self.viewModel.model.mobile = text;
            [self requestSave];
        }];
        tf.keyboardType = UIKeyboardTypeNumberPad;
    } else if ([model isEqual:self.viewModel.wx]) {
        [BRTFViewController start:@"微信号" detail:self.viewModel.wx.des des:@"" placeholder:@"请填写微信号" complete:^(NSString * _Nonnull text) {
            self.viewModel.wx.des = text;
            self.viewModel.model.wechat = text;
            [self requestSave];
        }];
    } else if ([model isEqual:self.viewModel.home]) {
        FYAddressPickerView *add = [FYAddressPickerView showWithComplete:^(FYAddressModel * _Nonnull add) {
            self.viewModel.home.des = [NSString stringWithFormat:@"%@-%@",add.province, add.city];
            self.viewModel.model.provincename = add.province;
            self.viewModel.model.cityname = add.city;
            self.viewModel.model.provincecode = add.proCode;
            self.viewModel.model.citycode = add.cityCode;
            [self requestSave];
        }];
        add.comp = 2;
    }
}


@end
