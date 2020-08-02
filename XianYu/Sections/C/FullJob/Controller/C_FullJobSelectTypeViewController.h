//
//  C_FullJobSelectTypeViewController.h
//  XianYu
//
//  Created by lmh on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface C_FullJobSelectTypeViewController : BaseViewController

@property (nonatomic, strong) RACSubject *dataSubject;

@property (nonatomic, strong) NSMutableArray *selectArray;

@end

NS_ASSUME_NONNULL_END
