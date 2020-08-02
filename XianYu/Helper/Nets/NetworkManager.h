//
//  NetworkManager.h
//  XinBianLi
//
//  Created by lmh on 2017/10/10.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


typedef void(^CompleteBlock)(id result, int successCode, NSString *errowMessage);
typedef void(^ErrorBlock)(id error);
@interface NetworkManager : NSObject
@property (nonatomic, copy) NSString *myUrl;
@property (nonatomic, copy) CompleteBlock myCompleteBlock;
@property (nonatomic, copy) ErrorBlock myErrorBlock;



+(NetworkManager *)instance;

+ (void)sendReq:(NSDictionary *)params pageUrl:(NSString *)pageUrl complete:(void(^)(id result))complete;

+ (void)sendReq:(NSDictionary *)params pageUrl:(NSString *)pageUrl isLoading:(BOOL)isLoading complete:(void(^)(id result))complete;

+ (void)sendReq:(NSDictionary *)params pageUrl:(NSString *)pageUrl complete:(void(^)(id result))complete failure:(void(^)(NSInteger code, NSString *msg))failure;

+ (void)sendReq:(NSDictionary *)params pageUrl:(NSString *)pageUrl isLoading:(BOOL)isLoading complete:(void(^)(id result))complete failure:(void(^)(NSInteger code, NSString *msg))failure;

- (void)sendReq:(NSDictionary *)params pageUrl:(NSString *)pageUrl urlVersion:(NSString *)version   endLoad:(BOOL)isEnd viewController:(UIViewController *)viewController complete:(CompleteBlock)complete errorBlock:(ErrorBlock)errorBlock;

- (NSMutableDictionary *)setRequestPubicPrames:(NSDictionary *)pamram needLog:(BOOL)isLog;



@end
