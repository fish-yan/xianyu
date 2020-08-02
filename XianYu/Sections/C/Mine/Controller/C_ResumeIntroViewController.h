//
//  C_ResumeIntroViewController.h
//  XianYu
//
//  Created by lmh on 2019/7/24.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface C_ResumeIntroViewController : BaseViewController

@property (nonatomic, strong) RACSubject *saveSubject;

@property (nonatomic, copy) NSString *selfdes;

@end

NS_ASSUME_NONNULL_END
