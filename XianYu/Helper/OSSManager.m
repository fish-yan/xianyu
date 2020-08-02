//
//  OSSManager.m
//  XianYu
//
//  Created by lmh on 2019/7/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "OSSManager.h"

@implementation OSSManager

static OSSManager *share = nil;
+ (OSSManager *)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[self alloc]init];
        //        manager.infoModel = [[UserInfoModel alloc]init];
        //        manager.currentCityModel = [[CityModel alloc]init];
    });
    return share;
}


- (void)uploadImage:(UIImage *)image withSize:(CGSize)size withBlock:(ReturnBlock)block
{
    NSString *endpoint = @"oss-cn-hangzhou.aliyuncs.com";
    NSString *accessKeyId = @"LTAIJHKePmf5BzWM";
    NSString *accessKeySecret = @"z5qCgUhYYY7De7ZaYWQt3x1n5HhQCX";
    NSString *bucket = @"huayuanlove";
    UIImage *imagenew;
    if (size.width > 0) {
        imagenew = [self imageWithImageSimple:image scaledToSize:CGSizeMake(200, 200)];
    }
    else
    {
        imagenew = [self imageWithImageSimple:image scaledToSize:image.size];
    }
    
    
    NSData *imageData = UIImagePNGRepresentation(imagenew);

    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:accessKeyId
                                                                                                            secretKey:accessKeySecret];
    self.client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    // required fields

    put.bucketName = bucket;
    NSString *objectKeys = [NSString stringWithFormat:@"User/%@.jpg",[self getTimeNow]];
    
    put.objectKey = objectKeys;
    //put.uploadingFileURL = [NSURL fileURLWithPath:fullPath];
    put.uploadingData = imageData;
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * putTask = [self.client putObject:put];
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        task = [self.client presignPublicURLWithBucketName:bucket
                                        withObjectKey:objectKeys];
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(task.result);
            });
            NSLog(@"upload object success!");
            
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    
    
}

/**
 *  返回当前时间
 *
 *  @return <#return value description#>
 */
- (NSString *)getTimeNow
{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    //取出个随机数
    int last = arc4random() % 10000;
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@-%i", date,last];
    NSLog(@"%@", timeNow);
    return timeNow;
}

- (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
