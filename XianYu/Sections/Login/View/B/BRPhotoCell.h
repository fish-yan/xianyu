//
//  BRPhotoCell.h
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRPhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic, copy) NSString *photo;

@end

NS_ASSUME_NONNULL_END
