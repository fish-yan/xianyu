//
//  BRAddressModel.h
//  XianYu
//
//  Created by Yan on 2019/7/17.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRAddressModel : NSObject

@property (copy, nonatomic) NSString *id;

@property (copy, nonatomic) NSString *pname;

@property (copy, nonatomic) NSString *address;

@property (copy, nonatomic) NSString *provincecode;

@property (copy, nonatomic) NSString *citycode;

@property (copy, nonatomic) NSString *towncode;

@property (copy, nonatomic) NSString *lon;

@property (copy, nonatomic) NSString *lad;

@end

NS_ASSUME_NONNULL_END
