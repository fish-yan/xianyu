
//
//  BResumeDetailViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/22.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BResumeDetailViewController.h"
#import "BResumeModel.h"
#import "BResumeDetailCell.h"

@interface BResumeDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *workStatusLab;
@property (weak, nonatomic) IBOutlet UILabel *eduLab;
@property (weak, nonatomic) IBOutlet UILabel *expLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgV;
@property (weak, nonatomic) IBOutlet UILabel *jobTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *dismissionLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIView *tagsLab;

@property (weak, nonatomic) IBOutlet UILabel *introduceLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UIView *line2;

@property (weak, nonatomic) IBOutlet UIView *line1;
@property (strong, nonatomic) BResumeModel *model;

@end

@implementation BResumeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommanTool addLoadView:self.view];
    [[NSNotificationCenter defaultCenter] postNotificationName:notification_reload_resume_list object:nil];
    [self request];
}

- (void)request {
    NSDictionary *params = @{@"id": self.resumeId};
    [NetworkManager sendReq:params pageUrl:XY_B_getresumedetailed isLoading:NO  complete:^(id result) {
        [CommanTool removeViewType:4 parentView:self.view];
        [CommanTool removeViewType:4 parentView:self.tableView];
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            self.model = [BResumeModel yy_modelWithJSON:arr.firstObject];
            for (NSDictionary *dict in arr.firstObject[@"exps"]) {
                BResumeJobExpModel *expModel = [BResumeJobExpModel yy_modelWithJSON:dict];
                [self.model.jobExps addObject:expModel];
            }
        }
        [self configView];
        [self.tableView reloadData];
    } failure:^(NSInteger code, NSString *msg) {
        [CommanTool removeViewType:4 parentView:self.view];
        [CommanTool removeViewType:4 parentView:self.tableView];
        [CommanTool addNoDataView:self.tableView withImage:@"icon_no_data" contentStr:@"暂无内容"];
    }];
}

- (void)configView {
    [self.photoImgV sd_setImageWithURL:[NSURL URLWithString:self.model.photo]];
    self.nameLab.text = self.model.name;
    self.workStatusLab.text = self.model.jobstatus;
    if (self.model.age && self.model.age.length != 0) {
        self.ageLab.text = self.model.age;
    } else {
        self.ageLab.text = @"";
        self.line1.hidden = YES;
    }
    if (self.model.educationname && self.model.educationname.length != 0) {
        self.eduLab.text = self.model.educationname;
    } else {
        self.eduLab.text = @"";
        self.line2.hidden = YES;
    }
    if (self.model.jobexp && self.model.jobexp.length != 0) {
        self.expLab.text = self.model.jobexp;
    } else {
        self.expLab.text = @"";
        self.line2.hidden = YES;
    }
    self.workStatusLab.text = self.model.exparrtimestring;
    self.dismissionLab.text = [self transJobintention:self.model.jobintention];
    NSString *imgNm = [self.model.sex isEqualToString:@"男"] ? @"icon_c_mine_resume_man" : @"icon_c_mine_resume_women";
    self.sexImgV.image = [UIImage imageNamed:imgNm];
    NSString *typeNm = [self.model.jobtype isEqualToString:@"0"] ? @"全职" : @"兼职";
    self.jobTypeLab.text = [NSString stringWithFormat:@"求职类型：%@", typeNm ?: @""];
    self.addressLab.text = [NSString stringWithFormat:@"求职地点：%@", self.model.jobaddress ?: @""];
    NSString *fullMoney = [NSString stringWithFormat:@"期望月薪：%@", self.model.wantwage ?: @""];
    NSString *partMoney = [NSString stringWithFormat:@"期望月薪：%@", self.model.dailywage ?: @""];
    self.moneyLab.text = [self.model.jobtype isEqualToString:@"0"] ?  fullMoney : partMoney;
    CGFloat height = [XYTagsView initTagsWith:self.tagsLab array:[self.model.wantjob componentsSeparatedByString:@"&"]];
    height = MAX(26, height);
    self.height.constant = height;
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, KScreenWidth, 334 + height);
    self.introduceLab.text = self.model.selfdes;
}

- (NSString *)transJobStatus:(NSString *)status {
    if ([status isEqualToString:@"0"]) {
        return @"离职";
    } else if ([status isEqualToString:@"1"]) {
        return @"在职";
    } else {
        return @"";
    }
}

- (NSString *)transJobintention:(NSString *)jobintention {
    if ([jobintention isEqualToString:@"0"]) {
        return @"正在积极找工作";
    } else if ([jobintention isEqualToString:@"1"]) {
        return @"随便逛逛";
    } else if ([jobintention isEqualToString:@"2"]) {
        return @"暂时不想找工作";
    } else {
        return @"";
    }
}
- (IBAction)chatAction:(UIButton *)sender {
    if (self.model.id && self.model.id.length != 0) {
        [[IMManager share] contractToBWithUserId:self.model.id withViewController:self];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.jobExps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BResumeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BResumeDetailCell" forIndexPath:indexPath];
    cell.model = self.model.jobExps[indexPath.row];
    return cell;
}

@end
