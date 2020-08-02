//
//  BMStoreManagerModel.h
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMStoreManagerModel : BaseModel

@property (copy, nonatomic) NSString *id;

@property (copy, nonatomic) NSString *shopname;

@property (copy, nonatomic) NSString *idenname;

@property (copy, nonatomic) NSString *address;

@property (copy, nonatomic) NSString *lon;

@property (copy, nonatomic) NSString *lad;

@property (copy, nonatomic) NSString *auditstatus;

@end

NS_ASSUME_NONNULL_END
