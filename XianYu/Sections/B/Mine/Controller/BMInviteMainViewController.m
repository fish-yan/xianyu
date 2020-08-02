
//
//  BMInviteMainViewController.m
//  XianYu
//
//  Created by Yan on 2019/9/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BMInviteMainViewController.h"
#import "BMInviteModel.h"
#import "BMInviteViewController.h"


@interface BMInviteMainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIButton *tixianBtn;
@property (weak, nonatomic) IBOutlet UILabel *inviteCountLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (strong, nonatomic) BMInviteModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *qrImgV;

@end

@implementation BMInviteMainViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.qrImgV && self.shareModel.qrcodeUrl) {
        [self.qrImgV sd_setImageWithURL:[NSURL URLWithString:self.shareModel.qrcodeUrl]];
    }
}

- (void)configView {
    self.moneyLab.text = self.model.taskmoney ?: @"0";
    BOOL isEnable = [self.model.isrefund isEqualToString:@"1"] && ![self.moneyLab.text isEqualToString:@"0"];
    self.tixianBtn.enabled = isEnable;
    self.tixianBtn.backgroundColor = isEnable ? UIColorFromRGB(0xEFF7F2) : UIColorFromRGB(0xf5f5f5);
    self.tixianBtn.layer.bcolor = UIColorFromRGB(0xa5a5a5);
    if ([self.model.isrefund isEqualToString:@"0"]) {
        [self.tixianBtn setTitle:@"任务未完成" forState:(UIControlStateDisabled)];
    }
    if ([self.model.isrefund isEqualToString:@"3"]) {
        [self.tixianBtn setTitle:@"提现已完成" forState:(UIControlStateDisabled)];
    }
    NSString *text = [self.model.taskfinish isEqualToString:@"0"] ? @"未完成" : @"已完成";
    self.inviteCountLab.text = [NSString stringWithFormat:@"%@(%@/%@)", text, self.model.tasksucces, self.model.tasktotal];
    self.desLab.text = self.model.taskdesc;
}

- (IBAction)shareAction:(UIButton *)sender {
    FYShareViewController *shareVC = [[FYShareViewController alloc] init:self.shareModel.url title:self.shareModel.title des:self.shareModel.des img:self.shareModel.img];
    [self presentViewController:shareVC animated:true completion:nil];
}
- (IBAction)shareToFriend:(UIButton *)sender {
    FYShareViewController *shareVC = [[FYShareViewController alloc] init:self.shareModel.url title:self.shareModel.title des:self.shareModel.des img:self.shareModel.img];
    [shareVC wxSigleShare:UMSocialPlatformType_WechatSession];
}

- (IBAction)shareToTimeLine:(UIButton *)sender {
    FYShareViewController *shareVC = [[FYShareViewController alloc] init:self.shareModel.url title:self.shareModel.title des:self.shareModel.des img:self.shareModel.img];
    [shareVC wxSigleShare:UMSocialPlatformType_WechatTimeLine];
}


- (void)request {
    [NetworkManager sendReq:nil pageUrl:@"getinvitefriends" complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr && arr.count > 0) {
            self.model = [BMInviteModel yy_modelWithJSON:arr.firstObject];
            [self configView];
        }
    }];
    
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"qrCode"]) {
        BMInviteMainViewController *vc = [segue destinationViewController];
        vc.shareModel = self.shareModel;
    } else if ([segue.identifier isEqualToString:@"BMInvite"]) {
        BMInviteViewController *vc = segue.destinationViewController;
        vc.friends = self.model.friends;
        vc.finishFriends = self.model.finishfriends;
    }
}


@end
