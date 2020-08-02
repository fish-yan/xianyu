//
//  BMSetViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/28.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BMSetViewController.h"

@interface BMSetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cacheLab;

@end

@implementation BMSetViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat folderSize =[[SDImageCache sharedImageCache] totalDiskSize]/1024.0/1024.0;
    self.cacheLab.text = [NSString stringWithFormat:@"%.1fM", folderSize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)cleanCacheAction:(UIButton *)sender {
    [UserManager.share clearMobileCacheWithViewController:self withBlock:^{
        CGFloat folderSize =[[SDImageCache sharedImageCache] totalDiskSize]/1024.0/1024.0;
        self.cacheLab.text = [NSString stringWithFormat:@"%.1fM", folderSize];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)logoutAction:(UIButton *)sender {
    [UserManager.share getLoginOut];
}
- (IBAction)gradeAction:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@",XY_AppleStore_Appid]]];
}

@end
