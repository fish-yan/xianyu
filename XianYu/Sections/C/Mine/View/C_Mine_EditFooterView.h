//
//  C_Mine_EditFooterView.h
//  XianYu
//
//  Created by Yan on 2019/8/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface C_Mine_EditFooterView : UIView

@property (copy, nonatomic) NSString *img1;

@property (copy, nonatomic) NSString *img2;

@property (copy, nonatomic) NSString *img3;

@property (copy, nonatomic) NSString *img4;

@property (assign, nonatomic) NSInteger imgCount; //default = 3

@property (copy, nonatomic) void(^complete)(NSString *imgStr, NSInteger tag);

- (void)configImgs;

@end

NS_ASSUME_NONNULL_END
