//
//  OSSManager.h
//  XianYu
//
//  Created by lmh on 2019/7/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReturnUrlBlock)(NSString *url);

@interface OSSManager : BaseModel

+ (OSSManager *)share;

@property (nonatomic, strong) OSSClient *client;

@property(nonatomic, assign) ReturnUrlBlock urlBlcok;

- (void)uploadImage:(UIImage *)image withSize:(CGSize)size withBlock:(ReturnBlock)block;

@end

NS_ASSUME_NONNULL_END
