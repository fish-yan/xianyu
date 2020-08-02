//
//  DefineEnum.h
//  XinBianLi
//
//  Created by lmh on 2017/10/11.
//  Copyright © 2017年 lmh. All rights reserved.
//

#ifndef DefineEnum_h
#define DefineEnum_h

//全局返回通用配置选项
typedef NS_ENUM(NSInteger, SelectorBackType){
    SelectorBackTypePopBack = 0,
    SelectorBackTypeDismiss,
    SelectorBackTypePoptoRoot
};


typedef NS_ENUM(NSInteger, NavigationBackType){
    NavigationBackType_Clear = 0, //隐藏
    NavigationBackType_Black, //黑色
    NavigationBackType_White, //白色
};




typedef NS_ENUM(NSInteger, WKWebViewNavColorFromType){
    WKWebViewNavColorFromType_White = 0, //白色
    WKWebViewNavColorFromType_Yellow, //黄色
    WKWebViewNavColorFromType_Clear, //透明
    WKWebViewNavColorFromType_Red, //红色
};




typedef enum : NSUInteger {
    WKWebViewFromType_B,
    WKWebViewFromType_C,
    WKWebViewFromType_ShareRecruit,
} WKWebViewFromType;


typedef enum : NSUInteger {
    C_FullJobSelectOrderType_Advance,
    C_FullJobSelectOrderType_Distance,
    C_FullJobSelectOrderType_Release,
    C_FullJobSelectOrderType_Hight,
    
} C_FullJobSelectOrderType;


typedef enum : NSUInteger {
    C_PartJobTableViewType_Area = 1,
    C_PartJobTableViewType_MoneyType,
    C_PartJobTableViewType_PaiXu,
    
} C_PartJobTableViewType;

typedef enum : NSUInteger {
    XYB = 0,
    XYC = 1,
} XYLoginclient;


typedef enum : NSUInteger {
    XY_News_IdenfifierType_C = 0,
    XY_News_IdenfifierType_B = 1,
} XY_News_IdenfifierType;

typedef enum : NSUInteger {
    XY_C_FullJob_HeadClickType_Area = 0,
    XY_C_FullJob_HeadClickType_Distance = 1,
    XY_C_FullJob_HeadClickType_Release=3,
} XY_C_FullJob_HeadClickType;








#endif /* DefineEnum_h */
