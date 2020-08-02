//
//  BJobDesViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/19.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BJobDesViewController.h"

@interface BJobDesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UITextView *desTV;
@property (weak, nonatomic) IBOutlet UITextView *empTV;
@property (weak, nonatomic) IBOutlet UILabel *empLab;
@property (weak, nonatomic) IBOutlet UIButton *empBtn;

@end

@implementation BJobDesViewController

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
    self.countLab.text = [NSString stringWithFormat:@"%ld/1000", self.desTV.text.length];
    [self request];
}

- (void)request {
    NSDictionary *params = @{@"id":self.positionId ?: @""};
    [NetworkManager sendReq:params pageUrl:@"gettemplate" complete:^(id result) {
        NSArray *arr = result[@"data"];
        self.empTV.hidden = arr.count == 0;
        self.empBtn.hidden = arr.count == 0;
        self.empLab.hidden = arr.count == 0;
        if (arr.count > 0) {
            self.empTV.text = arr.firstObject;
        }
    }];
}


- (IBAction)commitAction:(UIBarButtonItem *)sender {
    if (self.desTV.text.length <= 0) {
        [ToastView show:@"请填写职位描述"];
        return;
    }
    !self.complete ?: self.complete(self.desTV.text);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)empAction:(UIButton *)sender {
    self.desTV.text = self.empTV.text;
    self.placeholder.hidden = self.desTV.text.length != 0;
    self.countLab.text = [NSString stringWithFormat:@"%ld/1000", self.desTV.text.length];
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
    if (textView.text.length > 1000) {
        textView.text = [textView.text substringToIndex:1000];
    }
    self.placeholder.hidden = textView.text.length != 0;
    self.countLab.text = [NSString stringWithFormat:@"%ld/1000", textView.text.length];
}

@end
