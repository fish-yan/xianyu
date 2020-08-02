//
//  BPostJobVM.m
//  XianYu
//
//  Created by Yan on 2019/7/18.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BPostJobVM.h"

@implementation BPostJobVM

@synthesize jobModel = _jobModel;

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 0) {
        self.pay.title = @"职位薪资";
        self.dataSource = @[@[self.postion, self.postionNm, self.pay, self.benefit, self.store, self.address, self.tel, self.des], @[ self.age, self.degree, self.exp]];
    } else {
        self.pay.title = @"薪资结算";
        self.dataSource = @[@[self.postion, self.postionNm, self.pay, self.benefit, self.store, self.address, self.workDate, self.tel, self.des], @[self.age, self.degree, self.exp, ]];
    }
}

- (NSArray<NSArray<LTCellModel*>*> *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@[self.postion, self.postionNm, self.pay, self.benefit, self.address, self.store, self.tel, self.des], @[self.age, self.degree, self.exp, ]];
    }
    return _dataSource;
}

- (LTCellModel *)postion {
    if (!_postion) {
        _postion = [LTCellModel initWith:@"职位类型" des:@"" placeholder:@"请选择" type: LTSelected];
    }
    return _postion;
}

- (LTCellModel *)postionNm {
    if (!_postionNm) {
        _postionNm = [LTCellModel initWith:@"职位名称" des:@"" placeholder:@"请填写" type: LTSelected];
    }
    return _postionNm;
}

- (LTCellModel *)pay {
    if (!_pay) {
        _pay = [LTCellModel initWith:@"薪资结算" des:@"" placeholder:@"请填写" type: LTSelected];
    }
    return _pay;
}

- (LTCellModel *)age {
    if (!_age) {
        _age = [LTCellModel initWith:@"年龄要求" des:@"" placeholder:@"请选择" type: LTSelected];
    }
    return _age;
}

- (LTCellModel *)degree {
    if (!_degree) {
        _degree = [LTCellModel initWith:@"学历要求" des:@"" placeholder:@"请选择" type: LTSelected];
    }
    return _degree;
}

- (LTCellModel *)exp {
    if (!_exp) {
        _exp = [LTCellModel initWith:@"经验要求" des:@"" placeholder:@"请选择" type: LTSelected];
    }
    return _exp;
}

- (LTCellModel *)benefit {
    if (!_benefit) {
        _benefit = [LTCellModel initWith:@"工作福利" des:@"" placeholder:@"请选择" type: LTSelected];
    }
    return _benefit;
}

- (LTCellModel *)address {
    if (!_address) {
        _address = [LTCellModel initWith:@"" des:@"" placeholder:@"" type: LTDisable];
    }
    return _address;
}

- (LTCellModel *)workDate {
    if (!_workDate) {
        _workDate = [LTCellModel initWith:@"工作时间" des:@"" placeholder:@"请选择" type: LTSelected];
    }
    return _workDate;
}

- (LTCellModel *)store {
    if (!_store) {
        _store = [LTCellModel initWith:@"工作门店" des:@"" placeholder:@"请选择" type: LTSelected];
    }
    return _store;
}

- (LTCellModel *)tel {
    if (!_tel) {
        _tel = [LTCellModel initWith:@"联系电话" des:@"" placeholder:@"请填写" type: LTSelected];
    }
    return _tel;
}

- (LTCellModel *)des {
    if (!_des) {
        _des = [LTCellModel initWith:@"职位描述" des:@"" placeholder:@"请填写" type: LTSelected];
    }
    return _des;
}

- (void)setJobModel:(BJobModel *)jobModel {
    _jobModel = jobModel;
    self.postion.des = jobModel.classname;
    self.pay.des = jobModel.wagedes;
    self.age.des = jobModel.age;
    self.degree.des = jobModel.educationname;
    self.exp.des = jobModel.jobexp;
    self.benefit.des = [jobModel.welfare componentsJoinedByString:@"&"];
    jobModel.welfarenew = [jobModel.welfare componentsJoinedByString:@"&"];
    self.store.des = jobModel.shopname;
    self.address.des = jobModel.address;
    self.postionNm.des = jobModel.jobname;
    self.tel.des = jobModel.mobile;
    self.des.des = jobModel.jobdesc;
    self.jobModel.startDate = [self transDate:jobModel.startDate];
    self.jobModel.endDate = [self transDate:jobModel.endDate];
    self.workDate.des = [NSString stringWithFormat:@"%@-%@", jobModel.startDate, jobModel.endDate];
}

- (BJobModel *)jobModel {
    if (!_jobModel) {
        _jobModel = [[BJobModel alloc]init];
    }
    return _jobModel;
}

- (NSString *)transEdu:(NSString *)edu {
    if ([edu isEqualToString:@"不限"]) {
        return @"10";
    } else if ([edu isEqualToString:@"小学"]) {
        return @"20";
    } else if ([edu isEqualToString:@"初中"]) {
        return @"30";
    } else if ([edu isEqualToString:@"高中"]) {
        return @"40";
    } else if ([edu isEqualToString:@"中专"]) {
        return @"41";
    } else if ([edu isEqualToString:@"大专"]) {
        return @"50";
    } else if ([edu isEqualToString:@"本科"]) {
        return @"60";
    } else if ([edu isEqualToString:@"硕士"]) {
        return @"70";
    } else if ([edu isEqualToString:@"博士"]) {
        return @"80";
    }
    return @"";
}

- (NSString *)transDate:(NSString *)dateStr {
    NSDateFormatter *f = [[NSDateFormatter alloc]init];
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter *f1 = [[NSDateFormatter alloc]init];
    f1.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [f dateFromString:dateStr];
    if (date == nil) {
        return @"";
    }
    NSString *s = [f1 stringFromDate:date];
    if (s == nil) {
        return @"";
    }
    return s;
}

- (void)requestSaveJob:(void(^)(BOOL success))complete {
    if (![self checkParams]) {
        return;
    }
    NSDictionary *params = [self getParams];
    NSString *API = XY_B_updatemyreleasejob;
    if (self.type == 0) {
        API = XY_B_updatemyreleasejob;
    } else {
        API = XY_B_updatemyreleasepartjob;
    }
    [NetworkManager sendReq:params pageUrl:API complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            self.jobModel.id = arr.firstObject[@"id"];
        }
        complete(YES);
    }];
}

- (BOOL)checkParams {
    if (self.jobModel.classid.length == 0) {
        [ToastView show:@"请选择职位类型"];
        return NO;
    }
    if (self.jobModel.wagedes.length == 0) {
        [ToastView show:@"请填写职位薪资"];
        return NO;
    }
    if (self.jobModel.age.length == 0) {
        [ToastView show:@"请选择年龄要求"];
        return NO;
    }
    if (self.jobModel.education.length == 0) {
        [ToastView show:@"请选择学历要求"];
        return NO;
    }
    if (self.jobModel.jobexp.length == 0) {
        [ToastView show:@"请选择经验要求"];
        return NO;
    }
    if (self.jobModel.welfarenew.length == 0) {
        [ToastView show:@"请选择工作福利"];
        return NO;
    }
    if (self.jobModel.shopid.length == 0) {
        [ToastView show:@"请选择工作门店"];
        return NO;
    }
    
    if (self.jobModel.mobile.length == 0) {
        [ToastView show:@"请填写联系电话"];
        return NO;
    }
    if (self.jobModel.jobdesc.length == 0) {
        [ToastView show:@"请填写职位描述"];
        return NO;
    }
    if (self.type == 1) {
        if (self.jobModel.wagetype.length == 0) {
            [ToastView show:@"请选择结算方式"];
            return NO;
        }
        if (self.jobModel.startDate.length == 0) {
            [ToastView show:@"请选择工作时间"];
            return NO;
        }
        if (self.jobModel.endDate.length == 0) {
            [ToastView show:@"请选择工作时间"];
            return NO;
        }
        if (self.jobModel.timeslot.length == 0) {
            [ToastView show:@"请选择工作时间段"];
            return NO;
        }
    }
    return YES;
}

- (NSDictionary *)getParams {
    
    NSMutableDictionary *params = @{@"id": self.jobModel.id ?: @"-1",
                                    @"classid": self.jobModel.classid,
                                    @"jobname": self.jobModel.jobname,
                                    @"wagedes":self.jobModel.wagedes,
                                    @"education":self.jobModel.education,
                                    @"jobexp":self.jobModel.jobexp,
                                    @"welfarenew":self.jobModel.welfarenew,
                                    @"shopid":self.jobModel.shopid,
                                    @"age":self.jobModel.age,
                                    @"mobile":self.jobModel.mobile,
                                    @"jobdesc":self.jobModel.jobdesc,
                                    }.mutableCopy;
    if (self.type == 1) {
        params[@"startDate"] = self.jobModel.startDate;
        params[@"endDate"] = self.jobModel.endDate;
        params[@"timeslot"] = self.jobModel.timeslot;
        params[@"wagetype"] = self.jobModel.wagetype;
    }
    return params;
}



@end
