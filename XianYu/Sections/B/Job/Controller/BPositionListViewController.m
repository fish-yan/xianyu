//
//  BPositionListViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BPositionListViewController.h"
#import "BPositionCell.h"
#import "BPositionDetailCell.h"

@interface BPositionListViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (nonatomic, strong) NSArray<JobTypeModel *> *jobTypes;
@property (nonatomic, strong) NSArray<JobDetailModel *> *jobDetails;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabWidth;

@end

@implementation BPositionListViewController

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
    if (self.type == 0) {
        self.tabWidth.constant = 120;
        for (JobTypeModel *model in self.jobTypes) {
            for (JobDetailModel *dModel in model.detailList) {
                if ([dModel.id isEqualToString:self.detailModel.id]) {
                    self.typeModel = model;
                    break;
                }
            }
        }
    } else {
        self.titleLab.text = @"兼职类型";
        self.tabWidth.constant = 0;
    }
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
    if (self.type == 0) {
        return CGSizeMake((width - 55)/3, 30);
    } else {
        return CGSizeMake((width - 60)/4, 30);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.jobDetails.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BPositionDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BPositionDetailCell" forIndexPath:indexPath];
    JobDetailModel *model = self.jobDetails[indexPath.row];
    BOOL isSelected = [self.detailModel.id isEqual:model.id];
    cell.titleLab.text = model.name;
    cell.titleLab.backgroundColor = isSelected ? UIColorFromRGB(0xEFF7F2) : UIColorFromRGB(0xF5F5F5);
    cell.titleLab.textColor = isSelected ? UIColorFromRGB(0x32A060) : UIColorFromRGB(0xA5A5A5);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JobDetailModel *model = self.jobDetails[indexPath.row];
    self.detailModel = model;
    [collectionView reloadData];
    !self.complete ?: self.complete(model);
    [self.navigationController popViewControllerAnimated:YES];
}



@end
