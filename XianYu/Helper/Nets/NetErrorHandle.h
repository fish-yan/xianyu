//
//  NetErrorHandle.h
//  New_MeiChai
//
//  Created by lmh on 2018/6/26.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "BaseModel.h"

@interface NetErrorHandle : BaseModel

+ (NetErrorHandle *)defaultHandle;
- (void)registerNotification;
- (void)removeAllNotification;

@end
