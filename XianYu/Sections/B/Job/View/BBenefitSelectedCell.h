//
//  BBenefitSelectedCell.h
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBenefitSelectedCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (copy, nonatomic) void(^btnAction)(UIButton *btn);

@end

NS_ASSUME_NONNULL_END
