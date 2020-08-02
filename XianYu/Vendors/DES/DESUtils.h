//
//  DESUtils.h
//  jianshebao
//
//  Created by 吴孔锐 on 16/8/11.
//  Copyright © 2016年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, EncryType){
    EncryTypePassword = 0,
    EncryTypeElse
};
@interface DESUtils : NSObject
+(NSString *)encryptUseDES:(NSString *)clearText;

+(NSString *) encryptUseDES:(NSString *)clearText WithEncryType:(EncryType)type;
+ (NSString *)encodeUrlString:(NSString *)string;
+(NSString *)decryptUseDES:(NSString *)cipherText;
//替换字符
+(NSString *)base64StringFromBase64UrlEncodedString:(NSString *)base64UrlEncodedString;
@end
