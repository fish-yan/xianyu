//
//  BMMoreServiceViewController.m
//  XianYu
//
//  Created by Yan on 2019/8/2.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BMMoreServiceViewController.h"
#import "BMMoreServiceCell.h"
#import "BMMoreServiceHeaderView.h"
#import "BMMoreServiceFooterView.h"
#import "BMMoreServiceMode.h"

@interface BMMoreServiceViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) BMMoreServiceMode *model;

@end

@implementation BMMoreServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestGetService];
}

- (void)requestGetService {
    NSDictionary *params = @{};
    [NetworkManager sendReq:params pageUrl:@"customization" complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            self.model = [BMMoreServiceMode yy_modelWithJSON:arr.firstObject];
        }
        [self.collectionView reloadData];
    }];
}
- (IBAction)sendEmailAction:(UIButton *)sender {
    [NetworkManager sendReq:nil pageUrl:@"email" complete:^(id result) {
        [ToastView show:@"发送成功，我们会在一个工作日内联系您"];
    }];
}
- (IBAction)telAction:(UIButton *)sender {
    [UIApplication.sharedApplication openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", self.model.moblie]]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KScreenWidth - 5 * 14 - 10 - 26) / 4, (KScreenWidth - 5 * 14 - 10 - 26) / 4 + 20);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.company.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BMMoreServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BMMoreServiceCell" forIndexPath:indexPath];
    NSDictionary *dict = self.model.company[indexPath.row];
    [cell.imgV sd_setImageWithURL:dict[@"logo"]];
    cell.nameLab.text = dict[@"cname"];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BMMoreServiceHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"BMMoreServiceHeaderView" forIndexPath:indexPath];
        header.nameLab.text = self.model.name;
        header.detailLab.text = self.model.content;
        return header;
    } else {
        BMMoreServiceFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"BMMoreServiceFooterView" forIndexPath:indexPath];
        footer.telLab.text = [NSString stringWithFormat:@"咨询电话：%@", self.model.moblie ?: @""];
        footer.emailLab.text = [NSString stringWithFormat:@"企业邮箱：%@", self.model.email ?: @""];
        return footer;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat width = collectionView.frame.size.width;
    CGFloat height = [self.model.name boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    return CGSizeMake(width, height + 150);
}



@end
