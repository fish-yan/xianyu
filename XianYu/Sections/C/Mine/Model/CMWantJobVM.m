//
//  CMWantJobVM.m
//  XianYu
//
//  Created by Yan on 2019/7/26.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "CMWantJobVM.h"

@implementation CMWantJobVM

@synthesize model = _model;

- (NSMutableArray<LTCellModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = @[self.type, self.address, self.fullMoney, self.position].mutableCopy;
    }
    return _dataSource;
}

- (void)setModel:(BResumeModel *)model {
    _model = model.copy;
    if ([_model.jobtype isEqualToString:@"0"]) {
        self.type.des = @"全职";
    } else if ([_model.jobtype isEqualToString:@"1"]) {
        self.type.des = @"兼职";
    }
    self.address.des = _model.jobaddress;
    self.freeTime.des = _model.freetime;
    self.fullMoney.des = _model.wantwage;
    self.partMoney.des = _model.dailywage;
    self.position.des = _model.wantjob;
    [self configCells];
}

- (BResumeModel *)model {
    if (!_model) {
        _model = [[BResumeModel alloc]init];
    }
    return _model;
}

- (LTCellModel *)type {
    if (!_type) {
        _type = [LTCellModel initWith:@"求职类型" des:@"" placeholder:@"请选择" type:LTSelected];
    }
    return _type;
}

- (LTCellModel *)address {
    if (!_address) {
        _address = [LTCellModel initWith:@"期望工作地点" des:@"" placeholder:@"请选择" type:LTSelected];
    }
    return _address;
}

- (LTCellModel *)fullMoney {
    if (!_fullMoney) {
        _fullMoney = [LTCellModel initWith:@"期望薪资" des:@"" placeholder:@"请选择" type:LTSelected];
    }
    return _fullMoney;
}

- (LTCellModel *)partMoney {
    if (!_partMoney) {
        _partMoney = [LTCellModel initWith:@"期望日薪" des:@"" placeholder:@"请选择" type:LTSelected];
    }
    return _partMoney;
}

- (LTCellModel *)position {
    if (!_position) {
        _position = [LTCellModel initWith:@"期望职位" des:@"" placeholder:@"请选择" type:LTSelected];
    }
    return _position;
}

- (LTCellModel *)freeTime {
    if (!_freeTime) {
        _freeTime = [LTCellModel initWith:@"空闲时间" des:@"" placeholder:@"请选择" type:LTSelected];
    }
    return _freeTime;
}

- (void)configCells {
    if ([self.type.des isEqualToString:@"全职"]) {
        self.dataSource = @[self.type, self.address, self.fullMoney, self.position].mutableCopy;
    } else {
        self.dataSource = @[self.type, self.address, self.freeTime, self.partMoney, self.position].mutableCopy;
    }
}

@end
