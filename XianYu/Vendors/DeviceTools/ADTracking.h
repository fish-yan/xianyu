//
//  ADTracking.h
//  jianshebao
//
//  Created by 吴孔锐 on 16/8/4.
//  Copyright © 2016年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "NSString+MD5.h"
#import <AFNetworking.h>
@interface ADTracking : NSObject
+ (id)instance;
- (NSString *)macString;
- (NSString *)idfvString;
- (NSString *)idfaString;
@end
