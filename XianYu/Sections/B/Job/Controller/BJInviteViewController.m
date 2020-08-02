//
//  BJInviteViewController.m
//  XianYu
//
//  Created by Yan on 2019/9/26.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BJInviteViewController.h"
#import "ShareModel.h"

@interface BJInviteViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) ShareModel *shareModel;
@end

@implementation BJInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![UserManager.share.infoModel.havepay isEqualToString:@"1"]) {
        [self.btn setTitle:@"去选购套餐" forState:UIControlStateNormal];
    }
    [self request];
}

- (void)request {
    [NetworkManager sendReq:nil pageUrl:@"gotoinvitefriend" complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr && arr.count > 0) {
            NSDictionary *dict = arr.firstObject;
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:dict[@"sharepic"]] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                self.shareModel = [[ShareModel alloc]init];
                self.shareModel.title = dict[@"sharetitle"] ?: @"";
                self.shareModel.des = dict[@"sharedesc"] ?: @"";
                self.shareModel.url = dict[@"referurl"] ?: @"";
                self.shareModel.img = image;
                self.shareModel.qrcodeUrl = dict[@"qrcodeb"] ?: @"";
            }];
        }
    }];
}

- (IBAction)inviteAction:(UIButton *)sender {
    if (![UserManager.share.infoModel.havepay isEqualToString:@"1"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        FYShareViewController *shareVC = [[FYShareViewController alloc] init:self.shareModel.url title:self.shareModel.title des:self.shareModel.des img:self.shareModel.img];
        [self presentViewController:shareVC animated:true completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
