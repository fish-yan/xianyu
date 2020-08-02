//
//  BRTradeSelectorViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRTradeSelectorViewController.h"
#import "BRTradeCell.h"


@interface BRTradeSelectorViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic)BRTradeSelectorVM *viewModel;


@end

@implementation BRTradeSelectorViewController

- (BRTradeSelectorVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BRTradeSelectorVM alloc]init];
    }
    return _viewModel;
}

- (BRTradeModel *)selectModel {
    if (!_selectModel) {
        _selectModel = [[BRTradeModel alloc]init];
    }
    return _selectModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __block typeof(self) weakSelf = self;
    [self.viewModel requestTrade:^(BOOL success) {
        [weakSelf.collectionView reloadData];
    }];
    [self registCell];
}

- (void)registCell {
    [self.collectionView registerNib:[UINib nibWithNibName:@"BRTradeCell" bundle:nil] forCellWithReuseIdentifier:@"BRTradeCell"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// MARK: - UICollectionView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KScreenWidth - 77)/2, 33);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BRTradeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BRTradeCell" forIndexPath:indexPath];
    BRTradeModel *model = self.viewModel.dataSource[indexPath.row];
    BOOL isSelected = [model.id isEqualToString:self.selectModel.id];
    cell.titleLab.text = model.name;
    cell.isSelected = isSelected;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BRTradeModel *model = self.viewModel.dataSource[indexPath.row];
    self.selectModel = model;
    [collectionView reloadData];
    !self.complete ?: self.complete(model);
    [self.navigationController popViewControllerAnimated:YES];
}


@end
