//
//  XYDobuleASViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "XYDobuleASViewController.h"
#import "XYActionSheetCell.h"

@interface XYTableView : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray<NSNumber *> *arr;
@property (weak, nonatomic) UITableView *tableView;
@property (nonatomic, copy) NSNumber *selected;
@property (nonatomic, copy) NSNumber *min;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *selectUnit;
@property (assign, nonatomic) NSInteger type;
@property (strong, nonatomic) NSTimer *completeTimer;
@property (copy, nonatomic) void(^complete)(NSNumber *num);
@property (assign, nonatomic) BOOL isSetInset;

- (void)setCurrentNum:(NSNumber *)num;

@end

@implementation XYTableView

- (void)setCurrentNum:(NSNumber *)num {
    self.selected = num;
    [self.tableView setContentOffset:CGPointMake(0, [self.arr indexOfObject:self.selected] * 41) animated:NO];    
}

- (void)setArr:(NSArray<NSNumber *> *)arr {
    _arr = arr;
    if (arr.count > 0) {
        self.min = arr.firstObject;
    }
}

- (void)setMin:(NSNumber *)min {
    _min = min;
    NSInteger index = [self.arr indexOfObject:min];
    if (min.integerValue > self.selected.integerValue) {
        [self.tableView setContentOffset:CGPointMake(0, index * 41) animated:YES];
        self.isSetInset = YES;
    } else {
        self.tableView.contentInset = UIEdgeInsetsMake(-index * 41, 0, 0, 0);
    }
    
}

- (void)setUnit:(NSString *)unit {
    _unit = unit;
    [self.tableView reloadData];
}

- (void)setSelectUnit:(NSString *)selectUnit {
    _selectUnit = selectUnit;
    [self.tableView reloadData];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.unit = @"";
        self.selectUnit = @"";
    }
    return self;
}

// MARK: - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XYActionSheetCell" forIndexPath:indexPath];
    NSNumber *title = self.arr[indexPath.row];
    BOOL isSelected = [title isEqual:self.selected];
    cell.titleLab.textColor = isSelected ? Color_Blue_32A060 : Color_Black_323232;
    cell.titleLab.text = [NSString stringWithFormat:@"%@%@",title, self.unit];
    if (isSelected) {
        cell.titleLab.text = [NSString stringWithFormat:@"%@%@%@",title, self.unit, self.selectUnit];
    }
    if (self.type == 0) {
        cell.selectdImg.hidden = YES;
    } else {
        cell.selectdImg.hidden = !isSelected;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 41;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selected = self.arr[indexPath.row];
    if (indexPath.row < [self.arr indexOfObject:self.min]) {
        self.selected = self.min.copy;
    }
    [self.tableView setContentOffset:CGPointMake(0, [self.arr indexOfObject:self.selected] * 41) animated:YES];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = MIN(MAX(round(scrollView.contentOffset.y / 41.0), 0), self.arr.count - 1);
    NSNumber *currentNum = self.arr[index];
    NSLog(@"-----%@", currentNum);
    [self updateCurrent:currentNum];
    
}

- (void)updateCurrent:(NSNumber *)number {
    
    if (self.selected != number) {
        self.selected = number;
    }
    if (self.completeTimer) {
        [self.completeTimer invalidate];
        self.completeTimer = nil;
    }
    self.completeTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(completeAction) userInfo:nil repeats:NO];
}

- (void)completeAction {
    [self.tableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView setContentOffset:CGPointMake(0, [self.arr indexOfObject:self.selected] * 41) animated:YES];
        if (self.isSetInset) {
            NSInteger index = [self.arr indexOfObject:self.min];
            self.tableView.contentInset = UIEdgeInsetsMake(-index * 41, 0, 0, 0);
            self.isSetInset = NO;
        }
    });
    !self.complete ?: self.complete(self.selected);
}


@end


@interface XYDobuleASViewController () 
@property (weak, nonatomic) IBOutlet UITableView *firstTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;

@property (nonatomic, strong) NSArray<NSNumber *> *firstArr;
@property (nonatomic, strong) NSArray<NSNumber *> *secArr;
@property (nonatomic, copy) void(^complete)(NSNumber *first, NSNumber *second);

@property (nonatomic, strong) XYTableView *tab1;
@property (nonatomic, strong) XYTableView *tab2;

@end

@implementation XYDobuleASViewController

- (XYTableView *)tab1 {
    if (!_tab1) {
        _tab1 = [[XYTableView alloc]init];
        _tab1.type = 0;
        _tab1.arr = self.firstArr;
    }
    return _tab1;
}

- (XYTableView *)tab2 {
    if (!_tab2) {
        _tab2 = [[XYTableView alloc]init];
        _tab2.type = 1;
        _tab2.arr = self.secArr;
    }
    return _tab2;
}

- (void)setHeadTitle:(NSString *)headTitle {
    _headTitle = headTitle;
    self.titleLab.text = headTitle;
}

- (NSString *)unit {
    if (!_unit) {
        _unit = @"";
    }
    return _unit;
}

- (NSString *)selectUnit {
    if (!_selectUnit) {
        _selectUnit = @"";
    }
    return _selectUnit;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.bottom.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.alpha = 1;
        [self.view layoutIfNeeded];
    }];
    self.tab1.unit = self.unit;
    self.tab2.unit = self.unit;
    self.tab2.selectUnit = self.selectUnit;
    self.first = [NSNumber numberWithInteger:MAX([self.first integerValue], [self.tab1.min integerValue])];
    self.second =  [NSNumber numberWithInteger:MAX([self.second integerValue], [self.tab2.min integerValue])];
    [self.tab1 setCurrentNum:self.first];
    [self.tab2 setCurrentNum:self.second];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.alpha = 0;
    self.bottom.constant = -300;
    self.firstTableView.delegate = self.tab1;
    self.firstTableView.dataSource = self.tab1;
    self.secondTableView.delegate = self.tab2;
    self.secondTableView.dataSource = self.tab2;
    self.tab1.tableView = self.firstTableView;
    self.tab2.tableView = self.secondTableView;
    __block typeof(self) weakSelf = self;
    self.tab1.complete = ^(NSNumber *num) {
        for (NSNumber *n in weakSelf.secArr) {
            if (n.integerValue > num.integerValue) {
                weakSelf.tab2.min = n;
                break;
            }
        }
        weakSelf.first = num;
    };
    self.tab2.complete = ^(NSNumber *num) {
        weakSelf.second = num;
    };
}

+(XYDobuleASViewController *)show:(NSArray<NSNumber *> *)firstArr secArr:(NSArray<NSNumber *> *)secArr complete:(void(^)(NSNumber *first, NSNumber *second))complete {
    UIViewController *vc = [UIViewController visibleViewController];
    XYDobuleASViewController *xyvc = [[UIStoryboard storyboardWithName:@"XYPublic" bundle:nil] instantiateViewControllerWithIdentifier:@"XYDobuleASViewController"];
    xyvc.firstArr = firstArr;
    xyvc.secArr = secArr;
    xyvc.first = firstArr.firstObject;
    xyvc.second = secArr.firstObject;
    xyvc.complete = complete;
    [vc presentViewController:xyvc animated:NO completion:nil];
    return xyvc;
}

- (IBAction)cancelAction:(UIButton *)sender {
    self.bottom.constant = -300;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.alpha = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
}

- (IBAction)commitAction:(UIButton *)sender {
    self.complete(self.first, self.second);
    [self cancelAction:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.anyObject.view == self.view) {
        [self cancelAction:nil];
    }
}

@end
