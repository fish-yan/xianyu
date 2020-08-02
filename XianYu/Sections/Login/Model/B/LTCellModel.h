//
//  LTCellModel.h
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LTCellType) {
    LTNormal = 1,
    LTSelected,
    LTDisable,
};


@interface LTCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) LTCellType type;

+ (instancetype)initWith:(NSString *)title des:(NSString *)des placeholder:(NSString *)placeholder type:(LTCellType)type;

@end

NS_ASSUME_NONNULL_END
