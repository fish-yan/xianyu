//
//  CReportViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/28.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "CReportViewController.h"

@interface CReportViewController ()<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *tv;
@property (weak, nonatomic) IBOutlet UILabel *placeholdLab;
@property (strong, nonatomic) NSMutableArray *selected;
@property (strong, nonatomic) NSMutableArray<NSDictionary*> *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSString *key;
@property (copy, nonatomic) NSString *reportdesc;
@end

@implementation CReportViewController

- (NSMutableArray *)selected {
    if (!_selected) {
        _selected = [NSMutableArray array];
    }
    return _selected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestLoadReport];
}

- (IBAction)commitAction:(UIButton *)sender {
    if (self.selected.count == 0) {
        [ToastView show:@"请选择举报类型"];
        return;
    }
    [self requestReport];
}

- (void)requestLoadReport {
    [NetworkManager sendReq:nil pageUrl:@"reportlist" complete:^(id result) {
        self.dataSource = result[@"data"];
        [self.tableView reloadData];
    }];
}

- (void)requestReport {
    NSMutableString *mStr = [NSMutableString string];
    for (NSString *str in self.selected) {
        [mStr appendFormat:@"%@,",str];
    }
    if (mStr.length > 1) {
        NSString *str = [mStr substringToIndex:mStr.length -1];
        mStr = str;
    }
    NSDictionary *params = @{@"jobtype":self.jobtype, @"jobid":self.jobid, @"key":mStr, @"reportdesc":self.reportdesc};
    [NetworkManager sendReq:params pageUrl:@"reportjob" complete:^(id result) {
        NSInteger errcode = [result[@"code"] intValue];
        if (errcode == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel *titleLab = [cell viewWithTag:100];
    UILabel *detLab = [cell viewWithTag:101];
    UIImageView *img = [cell viewWithTag:102];
    NSDictionary *dict = self.dataSource[indexPath.row];
    titleLab.text = dict[@"title"];
    detLab.text = dict[@"content"];
    img.hidden = ![self.selected containsObject:dict[@"k"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataSource[indexPath.row];
    if ([self.selected containsObject:dict[@"k"]]) {
        [self.selected removeObject:dict[@"k"]];
    } else {
        [self.selected addObject:dict[@"k"]];
    }
    [self.tableView reloadData];
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeholdLab.hidden = textView.text.length != 0;
    if (self.placeholdLab.hidden) {
        self.reportdesc = textView.text;
    }
}

@end
