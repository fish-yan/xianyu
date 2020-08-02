//
//  IMManager.h
//  XianYu
//
//  Created by lmh on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMManager : BaseModel<RCIMUserInfoDataSource>

+ (IMManager *)share;

- (void)userImConnectWithUid:(NSString *)uid withName:(NSString *)name withPhoto:(NSString *)photo;

//C端沟通一下
- (void)connentJobid:(NSNumber *)jobid withJobType:(NSInteger)jobType viewController:(UIViewController *)viewController;

//B端沟通一下
- (void)contractToBWithUserId:(NSString *)jobid withViewController:(UIViewController *)viewController;

- (void)loginOutRongYun;

@end

NS_ASSUME_NONNULL_END
