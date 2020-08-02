//
//  B_News_ResumeModel.h
//  XianYu
//
//  Created by lmh on 2019/7/30.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface B_News_ResumeModel : BaseModel

@property (nonatomic, copy) NSString *identity;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *age;

@property (nonatomic, copy) NSString *educationname;

@property (nonatomic, copy) NSString *jobexp;

@property (nonatomic, copy) NSString *wantjob;

@property(nonatomic, assign) NSInteger shopsee;

@property (nonatomic, copy) NSString *jobstatus;

@property (nonatomic, copy) NSString *photo;

@end

NS_ASSUME_NONNULL_END
