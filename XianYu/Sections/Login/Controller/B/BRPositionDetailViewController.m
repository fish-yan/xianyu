
//
//  BRPositionDetailViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRPositionDetailViewController.h"

@interface BRPositionDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end

@implementation BRPositionDetailViewController

- (NSString *)name {
    if (!_name) {
        _name = @"";
    }
    return _name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tf.text = self.name;
    self.countLab.text = [NSString stringWithFormat:@"%ld/7",self.tf.text.length];
}
- (IBAction)saveAction:(id)sender {
    if (self.tf.text.length == 0) {
        [ToastView show:@"请填写我的职位"];
        return;
    }
    !self.complete ?: self.complete(self.tf.text);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)typeSelect:(UIButton *)sender {
    self.tf.text = sender.titleLabel.text;
    self.countLab.text = [NSString stringWithFormat:@"%ld/7",self.tf.text.length];
}

- (IBAction)textChange:(UITextField *)sender {
    if (self.tf.text.length > 7) {
        self.tf.text = [self.tf.text substringToIndex:7];
    }
    self.countLab.text = [NSString stringWithFormat:@"%ld/7",self.tf.text.length];
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
