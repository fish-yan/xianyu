//
//  DeviceName.h
//  jianshebao
//
//  Created by 吴孔锐 on 16/8/4.
//  Copyright © 2016年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/sysctl.h>
@interface DeviceName : NSObject
+ (NSString *)getCurrentDeviceModel;
@end
