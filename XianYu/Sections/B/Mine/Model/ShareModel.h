//
//  ShareModel.h
//  XianYu
//
//  Created by Yan on 2019/9/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShareModel : BaseModel
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *des;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, strong) UIImage *img;
@property(nonatomic, copy) NSString *qrcodeUrl;
@end

NS_ASSUME_NONNULL_END
