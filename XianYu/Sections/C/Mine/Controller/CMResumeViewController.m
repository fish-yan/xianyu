//
//  CMResumeViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/26.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "CMResumeViewController.h"
#import "BResumeModel.h"
#import "BResumeDetailCell.h"
#import "CMResumeAddCell.h"
#import "C_Mine_EditInfoViewController.h"
#import "CMWantJobViewController.h"
#import "CMWorkExpViewController.h"

@interface CMResumeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *eduLab;
@property (weak, nonatomic) IBOutlet UILabel *expLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgV;
@property (weak, nonatomic) IBOutlet UILabel *jobTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *dismissionLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIView *tagsLab;
@property (weak, nonatomic) IBOutlet UILabel *telLab;
@property (weak, nonatomic) IBOutlet UILabel *wxLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wantHeight;

@property (strong, nonatomic) BResumeModel *model;

@end

@implementation CMResumeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)request {
    self.infoHeight.constant = 0;
    self.wantHeight.constant = 0;
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, KScreenWidth, 200 + self.infoHeight.constant + self.wantHeight.constant);
    [NetworkManager sendReq:nil pageUrl:XY_C_ResumeInfoData complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            self.model = [BResumeModel yy_modelWithJSON:arr.firstObject];
            for (NSDictionary *dict in arr.firstObject[@"jexps"]) {
                BResumeJobExpModel *expModel = [BResumeJobExpModel yy_modelWithJSON:dict];
                [self.model.jobExps addObject:expModel];
            }
        }
        [self configView];
        [self.tableView reloadData];
    }];
}

- (void)requestSaveResume {
    NSDictionary *params = @{@"jobtype":self.model.jobtype ?: @"",
                             @"photo":self.model.photo ?: @"",
                             @"name":self.model.name ?: @"",
                             @"sex":self.model.sex ?: @"",
                             @"mobile":self.model.mobile ?: @"",
                             @"wechat":self.model.wechat ?: @"",
                             @"education":self.model.education ?: @"",
                             @"jobexp":self.model.jobexp ?: @"",
                             @"jobstatus":self.model.jobstatus ?: @"",
                             @"jobintention":self.model.jobintention ?: @"",
                             @"pandc":self.model.pandc ?: @"",
                             @"jobaddress":self.model.jobaddress ?: @"",
                             @"wantjob":self.model.wantjob ?: @"",
                             @"wantwage":self.model.wantwage ?: @"",
                             @"freetime":self.model.freetime ?: @"",
                             @"dailywage":self.model.dailywage ?: @"",
                             @"exparrtime":self.model.exparrtime ?: @"",
                             @"selfdes":self.model.selfdes ?: @"",
                             @"jobphotoone":self.model.jobphotoone ?: @"",
                             @"jobphototwo":self.model.jobphototwo ?: @"",
                             @"jobphotothree":self.model.jobphotothree ?: @"",
                             };
    [NetworkManager sendReq:params pageUrl:XY_C_SaveResumeInfoData complete:^(id result) {
        [self request];
    }];
}

- (void)configView {
    if (self.model.name && self.model.name.length != 0) {
        self.infoHeight.constant = 130;
    }
    [self.photoImgV sd_setImageWithURL:[NSURL URLWithString:self.model.photo]];
    self.nameLab.text = self.model.name;
    self.ageLab.text = self.model.age;
    self.eduLab.text = self.model.educationname;
    self.expLab.text = self.model.jobexp;
    self.telLab.text = [NSString stringWithFormat:@"手机号：%@", self.model.mobile ?: @""];
    self.wxLab.text = [NSString stringWithFormat:@"微信号：%@", self.model.wechat ?: @""];
    self.dismissionLab.text = [self transJobintention:self.model.jobintention];
    NSString *typeNm = @"";
    if ([self.model.jobtype isEqualToString:@"0"]) {
        typeNm = @"全职";
    } else if ([self.model.jobtype isEqualToString:@"1"]) {
        typeNm = @"兼职";
    }
    if (typeNm.length != 0) {
        self.wantHeight.constant = 117;
    }
    self.jobTypeLab.text = [NSString stringWithFormat:@"求职类型：%@", typeNm ?: @""];
    self.addressLab.text = [NSString stringWithFormat:@"期望地点：%@", self.model.jobaddress ?: @""];
    if (self.model.wantjob.length != 0) {
        [XYTagsView initTagsWith:self.tagsLab array:[self.model.wantjob componentsSeparatedByString:@"&"]];
    }
    
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, KScreenWidth, 200 + self.infoHeight.constant + self.wantHeight.constant);
    [self.tableView layoutIfNeeded];
}
- (IBAction)changeInfo:(UIButton *)sender {
    C_Mine_EditInfoViewController *VC = [C_Mine_EditInfoViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)wantStatus:(UIButton *)sender {
    XYActionSheetViewController *action = [XYActionSheetViewController show:xy_want_job_status complete:^(NSString * _Nonnull title) {
        self.model.jobintention = [self deTransJobintention:title];
        [self configView];
        [self requestSaveResume];
    }];
    action.headTitle = @"选择求职状态";
}

- (IBAction)workExp:(UIButton *)sender {
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
    } else if ([jobintention isEqualToString:@"正在积极找工作"]) {
        return @"0";
    } else if ([jobintention isEqualToString:@"随便逛逛"]) {
        return @"1";
    } else if ([jobintention isEqualToString:@"暂时不想找工作"]) {
        return @"2";
    } else {
        return @"";
    }
}

- (NSString *)deTransJobintention:(NSString *)jobintention {
    if ([jobintention isEqualToString:@"正在积极找工作"]) {
        return @"0";
    } else if ([jobintention isEqualToString:@"随便逛逛"]) {
        return @"1";
    } else if ([jobintention isEqualToString:@"暂时不想找工作"]) {
        return @"2";
    } else {
        return @"";
    }
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"CMWantJob"]) {
         CMWantJobViewController *vc = segue.destinationViewController;
         vc.viewModel.model = self.model;
         vc.complete = ^(BResumeModel * _Nonnull model) {
             self.model = model;
             [self configView];
             [self requestSaveResume];
         };
     } else if ([segue.identifier isEqualToString:@"CMWorkExp"]) {
         CMWorkExpViewController *vc = segue.destinationViewController;
         if ([sender isKindOfClass:[BResumeJobExpModel class]]) {
             vc.viewModel.model = (BResumeJobExpModel *)sender;
         }
         vc.complete = ^(BResumeJobExpModel * _Nonnull model) {
             [self request];
         };
     }
 }


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.model.jobExps.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BResumeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BResumeDetailCell" forIndexPath:indexPath];
        cell.model = self.model.jobExps[indexPath.row];
        return cell;
    } else {
        CMResumeAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CMResumeAddCell" forIndexPath:indexPath];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BResumeJobExpModel *model = nil;
    if (indexPath.section == 0) {
        model = self.model.jobExps[indexPath.row];
    }
    [self performSegueWithIdentifier:@"CMWorkExp" sender:model];
}


@end
