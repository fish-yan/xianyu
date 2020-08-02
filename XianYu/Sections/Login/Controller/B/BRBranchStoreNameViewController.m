//
//  BRBranchStoreNameViewController.m
//  XianYu
//
//  Created by Yan on 2019/9/23.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRBranchStoreNameViewController.h"

@interface BRBranchStoreNameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *storeNmLab;
@property (weak, nonatomic) IBOutlet UITextField *branchStoreNmTF;


@end

@implementation BRBranchStoreNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.storeNmLab.text = self.storeNm;
    self.branchStoreNmTF.text = self.branchStoreNm;
}

- (IBAction)saveAction:(id)sender {
    if (self.branchStoreNmTF.text.length <= 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请填写分店名称" duration:1.0f];
        return;
    }
    !self.complete ?: self.complete(self.branchStoreNmTF.text);
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)textChange:(UITextField *)sender {
    
}


@end
