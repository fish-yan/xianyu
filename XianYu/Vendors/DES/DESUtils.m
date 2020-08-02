//
//  DESUtils.m
//  jianshebao
//
//  Created by 吴孔锐 on 16/8/11.
//  Copyright © 2016年 lmh. All rights reserved.
//

#import "DESUtils.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>
#define DES_KEY @"blue!@#$%"

#define PASSWORD_KEY  @"8jyeytH#"

@implementation DESUtils

+(NSString *) encryptUseDES:(NSString *)clearText
{
    //这个iv 是DES加密的初始化向量，可以用和密钥一样的MD5字符
//    NSData * date = [iv dataUsingEncoding:NSUTF8StringEncoding];
    NSString *ciphertext = nil;
    NSUInteger dataLength = [clearText length];
    NSData *textData = [clearText dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char buffer[102400];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,//加密模式 kCCDecrypt 代表解密
                                          kCCAlgorithmDES,//加密方式
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,//填充算法
                                          [DES_KEY UTF8String], //密钥字符串
                                          kCCKeySizeDES,//加密位数
                                          nil,//初始化向量
                                          [textData bytes]  ,
                                          dataLength,
                                          buffer, 102400,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
//        NSLog(@"DES加密成功");
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [GTMBase64 stringByEncodingData:data];
    }else{
//        NSLog(@"DES加密失败");
    }
    return ciphertext;
}
+(NSString *) encryptUseDES:(NSString *)clearText WithEncryType:(EncryType)type
{
    //这个iv 是DES加密的初始化向量，可以用和密钥一样的MD5字符
    //    NSData * date = [iv dataUsingEncoding:NSUTF8StringEncoding];
    NSString *ciphertext = nil;
    NSUInteger dataLength = [clearText length];
    NSData *textData = [clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSString * encryKey ;
    switch (type) {
        case EncryTypePassword:
            encryKey = PASSWORD_KEY;
            break;
            
        default:
            break;
    }
    
    
    
    unsigned char buffer[102400];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,//加密模式 kCCDecrypt 代表解密
                                          kCCAlgorithmDES,//加密方式
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,//填充算法
                                          [encryKey UTF8String], //密钥字符串
                                          kCCKeySizeDES,//加密位数
                                          nil,//初始化向量
                                          [textData bytes]  ,
                                          dataLength,
                                          buffer, 102400,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
//        NSLog(@"DES加密成功");
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [GTMBase64 stringByEncodingData:data];
    }else{
//        NSLog(@"DES加密失败");
    }
    return ciphertext;
}
//Des解密
+(NSString *)decryptUseDES:(NSString *)cipherText
{
    //这个iv 是DES加密的初始化向量，可以用和密钥一样的MD5字符
    //    NSData * date = [iv dataUsingEncoding:NSUTF8StringEncoding];
    NSString *ciphertext = nil;
    NSUInteger dataLength = [cipherText length];
    NSData *textData = [cipherText dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char buffer[102400];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,//加密模式 kCCDecrypt 代表解密
                                          kCCAlgorithmDES,//加密方式
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,//填充算法
                                          [PASSWORD_KEY UTF8String], //密钥字符串
                                          kCCKeySizeDES,//加密位数
                                          nil,//初始化向量
                                          [textData bytes]  ,
                                          dataLength,
                                          buffer, 102400,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
//        NSLog(@"DES解密成功");
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }else{
//        NSLog(@"DES解密失败");
    }
    return ciphertext;
}

+(NSString *)base64StringFromBase64UrlEncodedString:(NSString *)base64UrlEncodedString
{
    NSString *s = base64UrlEncodedString;
    s = [s stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    s = [s stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return s;
}

// urlencode
+ (NSString *)encodeUrlString:(NSString *)string {
    return CFBridgingRelease(
                             CFURLCreateStringByAddingPercentEscapes(
                                                                     kCFAllocatorDefault,
                                                                     (__bridge CFStringRef)string,
                                                                     NULL,
                                                                     CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                     kCFStringEncodingUTF8)
                             );
}




@end
