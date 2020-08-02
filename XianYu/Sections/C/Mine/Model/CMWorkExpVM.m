//
//  CMWorkExpVM.m
//  XianYu
//
//  Created by Yan on 2019/7/26.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "CMWorkExpVM.h"

@implementation CMWorkExpVM

@synthesize model = _model;

- (NSMutableArray<LTCellModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = @[self.type, self.position, self.company, self.startDate, self.endDate, self.address, self.des].mutableCopy;
    }
    return _dataSource;
}



- (void)setModel:(BResumeJobExpModel *)model {
    _model = model.copy;

    self.type.des = _model.jobType;
    self.position.des = model.jobname;
    _model.jobposition = model.jobname;
    self.company.des = model.shopname;
    self.startDate.des = model.startdate;
    self.endDate.des = model.enddate;
    if (model.provincename.length > 0 && model.cityname.length > 0) {
        self.address.des = [NSString stringWithFormat:@"%@,%@", model.provincename ?: @"", model.cityname ?: @""];
    }
}

- (BResumeJobExpModel *)model {
    if (!_model) {
        _model = [[BResumeJobExpModel alloc]init];
    }
    return _model;
}

- (LTCellModel *)type {
    if (!_type) {
        _type = [LTCellModel initWith:@"工作类型" des:@"" placeholder:@"请选择" type:LTSelected];
    }
    return _type;
}

- (LTCellModel *)company {
    if (!_company) {
        _company = [LTCellModel initWith:@"所在公司" des:@"" placeholder:@"请选择" type:LTSelected];
    }
    return _company;
}

- (LTCellModel *)address {
    if (!_address) {
        _address = [LTCellModel initWith:@"工作地点" des:@"" placeholder:@"请选择" type:LTSelected];
    }
    return _address;
}

- (LTCellModel *)startDate {
    if (!_startDate) {
        _startDate = [LTCellModel initWith:@"开始时间" des:@"" placeholder:@"请选择" type:LTSelected];
    }
    return _startDate;
}

- (LTCellModel *)endDate {
    if (!_endDate) {
        _endDate = [LTCellModel initWith:@"结束时间" des:@"" placeholder:@"请选择" type:LTSelected];
    }
    return _endDate;
}

- (LTCellModel *)position {
    if (!_position) {
        _position = [LTCellModel initWith:@"工作职位" des:@"" placeholder:@"请选择" type:LTSelected];
    }
    return _position;
}

- (LTCellModel *)des {
    if (!_des) {
        _des = [LTCellModel initWith:@"工作描述" des:@"" placeholder:@"" type:LTDisable];
    }
    return _des;
}

- (BOOL)checkParams {
    if (self.model.jobType.length == 0) {
        [ToastView show:@"请选择工作类型"];
        return NO;
    }
    if (self.model.jobposition.length == 0) {
        [ToastView show:@"请选择工作职位"];
        return NO;
    }
    if (self.model.shopname.length == 0) {
        [ToastView show:@"请选择所在公司"];
        return NO;
    }
    if (self.model.startdate.length == 0) {
        [ToastView show:@"请选择开始时间"];
        return NO;
    }
    if (self.model.enddate.length == 0) {
        [ToastView show:@"请选择结束时间"];
        return NO;
    }
    return YES;
}

- (void)requestSaveWorkExp:(void(^)(BOOL success))complete {
    if (![self checkParams]) {
        return;
    }
    NSDictionary *params = @{@"id": self.model.id ?: @"-1",
                             @"jobType":[self.model.jobType isEqualToString:@"全职"] ? @"0" : @"1",
                             @"jobposition":self.model.jobposition,
                             @"shopname":self.model.shopname,
                             @"startDate":self.model.startdate,
                             @"endDate":self.model.enddate,
                             @"provincecode":self.model.provincecode ?: @"",
                             @"citycode":self.model.citycode ?: @"",
                             @"jobdescribe":self.model.jobdescribe ?: @"",
                             };
    [NetworkManager sendReq:params pageUrl:XY_C_addjobexp complete:^(id result) {
        complete(YES);
    }];
}

- (void)requestDeleteWorkExp:(void(^)(BOOL success))complete {
    if (!self.model.id || self.model.id.length == 0) {
        [ToastView show:@"当前工作经历尚未添加"];
        return;
    }
    NSDictionary *params = @{@"id":self.model.id};
    [NetworkManager sendReq:params pageUrl:XY_C_deljobexp complete:^(id result) {
        [ToastView show:@"删除成功"];
        complete(YES);
    }];
}


@end
