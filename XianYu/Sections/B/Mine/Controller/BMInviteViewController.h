//
//  BMInviteViewController.h
//  XianYu
//
//  Created by Yan on 2019/9/20.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMFriendModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMInviteViewController : UIViewController
@property (nonatomic, strong) NSArray<BMFriendModel *> *finishFriends;
@property (nonatomic, strong) NSArray<BMFriendModel *> *friends;
@end

NS_ASSUME_NONNULL_END
