
//
//  BRStoreDesViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRStoreDesViewController.h"


@interface BRStoreDesViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UITextView *desTV;

@end

@implementation BRStoreDesViewController

- (NSString *)des {
    if (!_des) {
        _des = @"";
    }
    return _des;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.desTV.text = self.des;
    self.placeholder.hidden = self.desTV.text.length != 0;
    self.countLab.text = [NSString stringWithFormat:@"%ld/300", self.desTV.text.length];
}

- (IBAction)commitAction:(UIBarButtonItem *)sender {
    if (self.desTV.text.length <= 0) {
        [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"请填写店铺简介" duration:1.0f];
        return;
    }
    !self.complete ?: self.complete(self.desTV.text);
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

// MARK: - UITextView
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 300) {
        textView.text = [textView.text substringToIndex:300];
    }
    self.placeholder.hidden = textView.text.length != 0;
    self.countLab.text = [NSString stringWithFormat:@"%ld/300", textView.text.length];
}


@end
