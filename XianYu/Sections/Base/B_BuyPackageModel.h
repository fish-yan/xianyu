//
//  B_BuyPackageModel.h
//  New_MeiChai
//
//  Created by lmh on 2018/7/4.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "BaseModel.h"
#import <StoreKit/StoreKit.h>
#import <PassKit/PassKit.h>
#import "DESUtils.h"

@interface B_BuyPackageModel : BaseModel<SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic, strong) UIViewController *viewController;

@property (nonatomic, copy) NSString *orderID;

@property (nonatomic, copy) NSString *buyCode;



+ (B_BuyPackageModel *)shareInstance;

//去苹果服务器请求商品
- (void)requestProductData:(NSString *)type withOrderID:(NSString *)orderID;





@end
