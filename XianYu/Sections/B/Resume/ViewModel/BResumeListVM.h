//
//  BResumeListVM.h
//  XianYu
//
//  Created by Yan on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BResumeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BResumeListVM : NSObject

@property (assign, nonatomic) NSInteger total;

@property (copy, nonatomic) NSString *shopsee;

@property (assign, nonatomic) NSInteger pageNum;

@property (strong, nonatomic) NSMutableArray<BResumeModel*> *dataSource;

- (void)requestResumeList:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
