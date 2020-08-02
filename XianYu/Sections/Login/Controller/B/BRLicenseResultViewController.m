//
//  BRLicenseResultViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRLicenseResultViewController.h"

@interface BRLicenseResultViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation BRLicenseResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}

- (void)configView {
    if (self.type == 1) {
        self.imgV.image = [UIImage imageNamed:@"icon_lic_wait"];
        self.titleLab.text = @"当前信息正在审核中\n请耐心等待";
        self.desLab.text = @"";
        [self.commitBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    } else {
        self.imgV.image = [UIImage imageNamed:@"icon_lic_refuse"];
        self.titleLab.text = @"当前认证信息未通过";
        self.desLab.text = @"请上传清晰正确的营业执照，填写和营业执照上 一致的名称，多次驳回，将降低认证通过率";
        [self.commitBtn setTitle:@"重新认证" forState:UIControlStateNormal];
    }
}
- (IBAction)commitAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        !self.complete ?: self.complete(NO);
    }];
    
}

- (IBAction)msgBtnAction:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:16602149187"]];
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
