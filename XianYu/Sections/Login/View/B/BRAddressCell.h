//
//  BRAddressCell.h
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (nonatomic, copy) void(^editorAction)(UIButton *sender);

@end

NS_ASSUME_NONNULL_END
