//
//  BMInviteModel.h
//  XianYu
//
//  Created by Yan on 2019/9/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"
#import "BMFriendModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMInviteModel : BaseModel
//是否可以申请退款  0不可以 1可以 2成功退款
@property (nonatomic, copy) NSString *isrefund;
//任务完成度(总计（需注册找招聘端）)
@property (nonatomic, copy) NSString *tasksucces;
//任务完成度(只计算付了钱的)
@property (nonatomic, copy) NSString *taskfinish;
//任务总量
@property (nonatomic, copy) NSString *tasktotal;
//完成活动的最后期限
@property (nonatomic, copy) NSString *tasktime;

//可提现金额
@property (nonatomic, copy) NSString *taskmoney;
//提现页面的连接
@property (nonatomic, copy) NSString *taskurl;
//提现对应的订单id
@property (nonatomic, copy) NSString *orderid;
//朋友
@property (nonatomic, strong) NSArray<BMFriendModel *> *finishfriends;
//朋友
@property (nonatomic, strong) NSArray<BMFriendModel *> *friends;
//邀请好友的说明介绍
@property (nonatomic, copy) NSString *taskdesc;
@end

NS_ASSUME_NONNULL_END
