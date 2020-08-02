//
//  C_PartJobSelectViewController.h
//  XianYu
//
//  Created by lmh on 2019/7/7.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_PartJobSelectViewController : BaseViewController

@property (nonatomic, strong) RACSubject *saveSubject;

@property (nonatomic, strong) NSMutableArray *selectArray;



@end

NS_ASSUME_NONNULL_END
