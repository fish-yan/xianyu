//
//  BRStoreLicenseViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRStoreLicenseViewController.h"
#import "BRLicenseResultViewController.h"
#import "XYPickPhotoUtils.h"

@interface BRStoreLicenseViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (assign, nonatomic) NSInteger type;
@end

@implementation BRStoreLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)addImgAction:(UIButton *)sender {
    [XYPickPhotoUtils pickPhoto:self complete:^(UIImage * _Nonnull img) {
        [OSSManager.share uploadImage:img withSize:CGSizeZero withBlock:^(id  _Nonnull result) {
            self.url = result;
            self.imgV.image = img;
        }];
    }];
}
- (IBAction)textChange:(UITextField *)sender {
    self.name = sender.text;
}

- (IBAction)commitAction:(UIButton *)sender {
    if (!self.shopId) {
        [ToastView show:@"店铺id为空"];
        return;
    }
    if (!self.url || self.url.length == 0) {
        [ToastView show:@"请上传营业执照"];
        return;
    }
    NSDictionary *params = @{@"shopid":self.shopId, @"licensephoto":self.url};
    [NetworkManager sendReq:params pageUrl:XY_B_auditstatusshop complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            self.type = [arr.firstObject[@"status"] integerValue];
        }
        [self performSegueWithIdentifier:@"BRLicenseResult" sender:nil];
    }];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BRLicenseResult"]) {
        BRLicenseResultViewController *vc = segue.destinationViewController;
        vc.type = self.type;
        vc.complete = ^(BOOL isMsg) {
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:notification_reload_store_list object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:notification_reload_store_info object:nil];
        };
    }
}


@end
