//
//  BMFriendModel.h
//  XianYu
//
//  Created by Yan on 2019/9/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMFriendModel : BaseModel
@property (nonatomic, copy) NSString *name;//名称
@property (nonatomic, copy) NSString * photo;//头像

@property (nonatomic, copy) NSString *friendStatus;//0已注册 1已付款


@end

NS_ASSUME_NONNULL_END
