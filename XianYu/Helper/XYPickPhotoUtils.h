//
//  XYPickPhotoUtils.h
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYPickPhotoUtils : NSObject

+ (void)pickPhoto:(UIViewController *)vc complete:(void(^)(UIImage *img))complete;

@end

NS_ASSUME_NONNULL_END
