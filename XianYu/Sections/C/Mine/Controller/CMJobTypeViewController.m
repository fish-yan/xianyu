//
//  CMJobTypeViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/27.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "CMJobTypeViewController.h"
#import "BPositionCell.h"
#import "BPositionDetailCell.h"
#import "BBenefitSelectedCell.h"
#import "BRTFViewController.h"

@interface CMJobTypeViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *selectedCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedHeight;
@property (nonatomic, strong) JobTypeModel *typeModel;
@property (nonatomic, strong) NSArray<JobTypeModel *> *jobTypes;
@property (nonatomic, strong) NSArray<JobDetailModel *> *jobDetails;
@end

@implementation CMJobTypeViewController

- (NSMutableArray<JobDetailModel *> *)selectedArr {
    if (!_selectedArr) {
        _selectedArr = [NSMutableArray array];
    }
    return _selectedArr;
}

- (JobTypeModel *)typeModel {
    if (!_typeModel) {
        if (_jobTypes.count > 0) {
            _typeModel = _jobTypes.firstObject;
        }
    }
    return _typeModel;
}

- (NSArray<JobDetailModel *> *)jobDetails {
    if (!_jobDetails) {
        if (self.type == 0) {
            _jobDetails = self.typeModel.detailList;
        } else {
            _jobDetails = UserManager.share.partJobList.mutableCopy;
        }
    }
    return _jobDetails;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.jobTypes = UserManager.share.jobList.mutableCopy;
    self.titleLab.text = self.typeModel.name;
    if (self.type == 0) {
        self.title = @"全职职位选择";
        self.tabWidth.constant = 120;
    } else {
        self.title = @"兼职职位选择";
        self.titleLab.text = @"兼职类型";
        self.tabWidth.constant = 0;
    }
}
- (IBAction)cleanAction:(UIButton *)sender {
    self.selectedArr = [NSMutableArray array];
    [self.collectionView reloadData];
    [self.selectedCollectionView reloadData];
}
- (IBAction)commitAction:(UIBarButtonItem *)sender {
    !self.complete ?: self.complete(self.selectedArr);
    [self.navigationController popViewControllerAnimated:YES];
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
    return self.jobTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPositionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BPositionCell" forIndexPath:indexPath];
    JobTypeModel *model = self.jobTypes[indexPath.row];
    cell.titleLab.text = model.name;
    BOOL isSelected = model.id == self.typeModel.id;
    cell.lineV.hidden = !isSelected;
    cell.backgroundColor = isSelected ? UIColor.whiteColor : UIColorFromRGB(0xFAFAFA);
    cell.textLabel.textColor = isSelected ? UIColorFromRGB(0x464646) : UIColorFromRGB(0x878787);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JobTypeModel *model = self.jobTypes[indexPath.row];
    self.typeModel = model;
    self.jobDetails = model.detailList;
    self.titleLab.text = model.name;
    [tableView reloadData];
    [self.collectionView reloadData];
}

// MARK: - UICollection

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.frame.size.width;
    if ([collectionView isEqual:self.collectionView]) {
        return CGSizeMake((width - 55)/3, 30);
    } else {
        return CGSizeMake((width - 50)/3, 30);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.collectionView]) {
        return self.jobDetails.count;
    } else {
        return self.selectedArr.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.collectionView]) {
        BPositionDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BPositionDetailCell" forIndexPath:indexPath];
        JobDetailModel *model = self.jobDetails[indexPath.row];
        cell.titleLab.text = model.name;
        BOOL isSelected = NO;
        for (JobDetailModel *m in self.selectedArr) {
            if ([m.id isEqualToString:model.id] || [m.name isEqualToString:model.name]) {
                isSelected = YES;
            }
        }
        cell.titleLab.backgroundColor = isSelected ? UIColorFromRGB(0xEFF7F2) : UIColorFromRGB(0xF5F5F5);
        cell.titleLab.textColor = isSelected ? UIColorFromRGB(0x32A060) : UIColorFromRGB(0xA5A5A5);
        return cell;
    } else {
        BBenefitSelectedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BBenefitSelectedCell" forIndexPath:indexPath];
        __block JobDetailModel *model = self.selectedArr[indexPath.row];
        cell.titleLab.text = model.name;
        cell.btnAction = ^(UIButton * _Nonnull btn) {
            [self.selectedArr removeObject:model];
            [self.collectionView reloadData];
            [self.selectedCollectionView reloadData];
        };
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.collectionView]) {
        if (self.selectedArr.count >= 3) {
            [ToastView show:@"最多只能选取3个"];
            return;
        }
        JobDetailModel *model = self.jobDetails[indexPath.row];
        BOOL isSelected = NO;
        for (JobDetailModel *m in self.selectedArr) {
            if ([m.id isEqualToString:model.id] || [m.name isEqualToString:model.name]) {
                isSelected = YES;
            }
        }
        if (!isSelected) {
            [self.selectedArr addObject:model];
            [collectionView reloadData];
            [self.selectedCollectionView reloadData];
        }
    }
}

@end
