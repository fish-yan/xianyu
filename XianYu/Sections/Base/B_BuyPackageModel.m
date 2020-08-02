//
//  B_BuyPackageModel.m
//  New_MeiChai
//
//  Created by lmh on 2018/7/4.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "B_BuyPackageModel.h"

@implementation B_BuyPackageModel

static B_BuyPackageModel *maneager = nil;
+ (B_BuyPackageModel *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        maneager = [[self alloc]init];
    });
    return maneager;
}

//去苹果服务器请求商品
- (void)requestProductData:(NSString *)type withOrderID:(NSString *)orderID{
    [SVProgressHUD showWithStatus:nil];
    self.buyCode = type;
    self.orderID = orderID;

     [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    if ([SKPaymentQueue canMakePayments]) {
        NSLog(@"-------------请求对应的产品信息----------------");
        NSArray *product = [[NSArray alloc] initWithObjects:type,nil];
        NSSet *nsset = [NSSet setWithArray:product];
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
        request.delegate = self;
        [request start];
    }
    else
    {
        NSLog(@"---------");
    }
   
}

//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    [SVProgressHUD dismiss];
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        [SVProgressHUD dismiss];
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
        if([pro.productIdentifier isEqualToString:self.buyCode]){
            p = pro;
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}


//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"支付失败"];
    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    [SVProgressHUD dismiss];
    NSLog(@"------------反馈信息结束-----------------");
}

//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"
/**
 *  验证购买，避免越狱软件模拟苹果请求达到非法购买问题
 *
 */
-(void)verifyPurchaseWithPaymentTransaction:(SKPaymentTransaction *)transaction{
    
    NSString *str = [[NSString alloc]initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    NSString *str1 = [DESUtils encodeUrlString:str];
    NSDictionary *params = @{
                             @"id":self.orderID,
                             @"receipt_data":str1
                             };
    [self sendBackReceiptData:params];
}
//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                NSLog(@"交易完成");
                // 发送到苹果服务器验证凭证
                [self verifyPurchaseWithPaymentTransaction:tran];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                break;
            case SKPaymentTransactionStateRestored:{
                NSLog(@"已经购买过商品");
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                NSLog(@"交易失败");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                [SVProgressHUD showErrorWithStatus:@"购买失败"];
            }
                break;
            default:
                break;
        }
    }
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
}


- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}



- (void)sendBackReceiptData:(NSDictionary *)params
{
    
    [[NetworkManager instance] sendReq:params pageUrl:@"changeordersuccessbyapple" urlVersion:nil endLoad:NO viewController:nil complete:^(id result, int successCode, NSString *errowMessage) {
        if (successCode == 0) {
             [[NSNotificationCenter defaultCenter] postNotificationName:@"App_RefreshBuy_Hunter" object:self userInfo:nil];;
        }
        else
        {
            [ToastView presentToastWithin:self.viewController.view withIcon:(APToastIconNone) text:errowMessage duration:1.0f];
        }
    } errorBlock:^(id error) {
        
    }];
    
    
   
}




@end
