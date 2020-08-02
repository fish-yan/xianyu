//
//  XYPickPhotoUtils.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "XYPickPhotoUtils.h"

@interface XYPickPhotoUtils ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIViewController *vc;

@property (nonatomic, copy) void(^complete)(UIImage *img);

@end

@implementation XYPickPhotoUtils

+ (XYPickPhotoUtils *)share {
    static dispatch_once_t onceToken;
    static XYPickPhotoUtils *s = nil;
    dispatch_once(&onceToken, ^{
        s = [[XYPickPhotoUtils alloc] init];
    });
    return s;
}


+ (void)pickPhoto:(UIViewController *)vc complete:(void(^)(UIImage *img))complete {
    [XYPickPhotoUtils share].vc = vc;
    [XYPickPhotoUtils share].complete = complete;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[XYPickPhotoUtils share] clickAltetView:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[XYPickPhotoUtils share] clickAltetView:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [vc presentViewController:alertController animated:YES completion:nil];
    
}

- (void)clickAltetView:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        [ToastView presentToastWithin:self.vc.view withIcon:(APToastIconNone) text:@"设备不支持" duration:1.0f];
        return;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = type;
    [self.vc presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.complete(image);
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
