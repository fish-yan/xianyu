//
//  NetStates.m
//  jianshebao
//
//  Created by 吴孔锐 on 16/8/4.
//  Copyright © 2016年 lmh. All rights reserved.
//

#import "NetStates.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>


@implementation NetStates
+(NSString *)getCurrentNetStates{
//    UIView * foregroundView = [[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"];
//    for (UIView * subView in foregroundView.subviews) {
//        if (![subView isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
//            return @"unKonw!";
//        }
//        int state = (int)[subView valueForKeyPath:@"dataNetworkType"];
//
//        switch (state) {
//            case 1:
//                return @"2G";
//                break;
//            case 2:
//                return @"3G";
//                break;
//            case 3:
//                return @"4G";
//                break;
//            case 5:
//                return @"WIFI";
//                break;
//            default:
//                return @"unKnow!";
//                break;
//        }
//
//    }
//    return @"unKnow!";
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *currentStatus = info.currentRadioAccessTechnology;
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
        return  @"GPRS";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
        return   @"2.75G EDGE";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
        return   @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
        return   @"3.5G HSDPA";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
        return   @"3.5G HSUPA";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
        return   @"2G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
        return   @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
        return   @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
        return   @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
        return   @"HRPD";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
        return   @"4G";
    }
    else
    {
        return @"unKnow";
    }
}



@end
