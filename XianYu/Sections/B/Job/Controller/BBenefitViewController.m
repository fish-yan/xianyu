//
//  BBenefitViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BBenefitViewController.h"
#import "BPositionCell.h"
#import "BPositionDetailCell.h"
#import "BBenefitSelectedCell.h"
#import "BBenefitVM.h"
#import "BRTFViewController.h"

@interface BBenefitViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *selectedCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedHeight;

@property (strong, nonatomic) NSMutableArray<NSString *> *selectedArr;
@property (strong, nonatomic) BBenefitVM *viewModel;

@end

@implementation BBenefitViewController

- (NSMutableArray<NSString *> *)selectedArr {
    if (!_selectedArr) {
        _selectedArr = [NSMutableArray array];
    }
    return _selectedArr;
}

- (void)setSelected:(NSString *)selected {
    _selected = selected;
    if (selected && selected.length != 0) {
        self.selectedArr = [selected componentsSeparatedByString:@"&"].mutableCopy;
    }
}

- (BBenefitVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BBenefitVM alloc]init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configHeight];
    __block typeof(self) weakSelf = self;
    [self.viewModel requestBenefit:^(BOOL success) {
        if (weakSelf.viewModel.dataSource.count > 0) {
            [weakSelf tableView:weakSelf.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            NSMutableArray *all = [NSMutableArray array];
            for (BBenefitModel *model in self.viewModel.dataSource) {
                [all addObjectsFromArray:model.list];
            }
            for (NSString *str in self.selectedArr) {
                if (![all containsObject:str]) {
                    [self.viewModel.dataSource.lastObject.list addObject:str];
                }
            }
        }
        [weakSelf.tableView reloadData];
        [weakSelf.collectionView reloadData];
    }];
}

- (IBAction)customAction:(UIButton *)sender {
    if (self.selectedArr.count >= 20) {
        [ToastView show:@"最多选择20个"];
        return;
    }
    [BRTFViewController start:@"自定义福利" detail:@"" des:@"" placeholder:@"自定义福利" complete:^(NSString * _Nonnull text) {
        BBenefitModel *last = self.viewModel.dataSource.lastObject;
        [last.list addObject:text];
        [self.selectedArr addObject:text];
        [self.collectionView reloadData];
        [self.selectedCollectionView reloadData];
        [self configHeight];
    }];
}

- (IBAction)commitAction:(UIBarButtonItem *)sender {
    self.selected = [self.selectedArr componentsJoinedByString:@"&"];
    !self.complete ?: self.complete(self.selected);
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
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPositionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BPositionCell" forIndexPath:indexPath];
    BBenefitModel *model = self.viewModel.dataSource[indexPath.row];
    cell.titleLab.text = model.value;
    cell.lineV.hidden = !model.isSelected;
    cell.backgroundColor = model.isSelected ? UIColor.whiteColor : UIColorFromRGB(0xFAFAFA);
    cell.textLabel.textColor = model.isSelected ? UIColorFromRGB(0x464646) : UIColorFromRGB(0x878787);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (BBenefitModel *m in self.viewModel.dataSource) {
        m.isSelected = NO;
    }
    BBenefitModel *model = self.viewModel.dataSource[indexPath.row];
    model.isSelected = YES;
    self.viewModel.subSource = model.list;
    [tableView reloadData];
    [self.collectionView reloadData];
}

// MARK: - UICollection

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.frame.size.width;
    if ([collectionView isEqual:self.collectionView]) {
        return CGSizeMake((width - 55)/3, 30);
    } else {
        return CGSizeMake((width - 45)/3, 30);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.collectionView]) {
        return self.viewModel.subSource.count;
    } else {
        return self.selectedArr.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.collectionView]) {
        BPositionDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BPositionDetailCell" forIndexPath:indexPath];
        NSString *str = self.viewModel.subSource[indexPath.row];
            cell.titleLab.text = str;
        BOOL isSelected = [self.selectedArr containsObject:str];
        cell.titleLab.backgroundColor = isSelected ? UIColorFromRGB(0xEFF7F2) : UIColorFromRGB(0xF5F5F5);
        cell.titleLab.textColor = isSelected ? UIColorFromRGB(0x32A060) : UIColorFromRGB(0xA5A5A5);
        return cell;
    } else {
        BBenefitSelectedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BBenefitSelectedCell" forIndexPath:indexPath];
        __block NSString *str = self.selectedArr[indexPath.row];
        cell.titleLab.text = str;
        cell.btnAction = ^(UIButton * _Nonnull btn) {
            [self.selectedArr removeObject:str];
            [self.collectionView reloadData];
            [self.selectedCollectionView reloadData];
        };
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.collectionView]) {
        if (self.selectedArr.count >= 20) {
            [ToastView show:@"最多选择20个"];
            return;
        }
        NSString *str = self.viewModel.subSource[indexPath.row];
        if (![self.selectedArr containsObject:str]) {
            [self.selectedArr addObject:str];
            [collectionView reloadData];
            [self.selectedCollectionView reloadData];
        }
        [self configHeight];
    }
}

- (void)configHeight {
    NSInteger row = self.selectedArr.count / 3;
    if (self.selectedArr.count == 0) {
        row = 0;
    }
    
    if (self.selectedArr.count % 3 != 0) {
        row += 1;
    }
    row = MIN(5, row);
    self.selectedHeight.constant = row * 40 + 30;
}


@end
