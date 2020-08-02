//
//  XYActionSheetViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/16.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "XYActionSheetViewController.h"
#import "XYActionSheetCell.h"

@interface XYActionSheetViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;

@property (nonatomic, strong) NSArray<NSString *> *dataSource;
@property (nonatomic, copy) void(^complete)(NSString *title);

@end

@implementation XYActionSheetViewController

- (void)setHeadTitle:(NSString *)headTitle {
    _headTitle = headTitle;
    self.titleLab.text = headTitle;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.bottom.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.alpha = 1;
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.alpha = 0;
    self.height.constant = 45 + self.dataSource.count * 42;
    self.bottom.constant = 100 + self.dataSource.count * 42;
}

+(XYActionSheetViewController *)show:(NSArray<NSString *> *)array complete:(void(^)(NSString *title))complete {
    UIViewController *vc = [UIViewController visibleViewController];
    XYActionSheetViewController *xyvc = [[UIStoryboard storyboardWithName:@"XYPublic" bundle:nil] instantiateViewControllerWithIdentifier:@"XYActionSheetViewController"];
    xyvc.dataSource = array;
    xyvc.complete = complete;
    [vc presentViewController:xyvc animated:NO completion:nil];
    return xyvc;
}

- (IBAction)cancelAction:(UIButton *)sender {
    self.bottom.constant = 150 + self.dataSource.count * 42;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.alpha = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
}
- (IBAction)commitAction:(UIButton *)sender {
    if (self.selectTitle.length != 0) {
        self.complete(self.selectTitle);
    }
    [self cancelAction:nil];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.anyObject.view == self.view) {
        [self cancelAction:nil];
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

// MARK: - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XYActionSheetCell" forIndexPath:indexPath];
    NSString *title = self.dataSource[indexPath.row];
    BOOL isSelected = [title isEqualToString:self.selectTitle];
    cell.selectdImg.hidden = !isSelected;
    cell.titleLab.textColor = isSelected ? Color_Blue_32A060 : Color_Black_323232;
    cell.titleLab.text = title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectTitle = self.dataSource[indexPath.row];
    [tableView reloadData];
}

@end
