//
//  BRInfoVM.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRInfoVM.h"

@implementation BRInfoVM

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 0) {
        self.dataSource = @[@[self.photo, self.name, self.sex], @[self.store]];
    } else {
        self.dataSource = @[@[self.photo, self.name, self.sex, self.tel, self.wx, self.home]];
    }
}

- (NSArray<NSArray<LTCellModel*>*> *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@[self.photo, self.name, self.sex], @[self.store]];
    }
    return _dataSource;
}

- (LTCellModel *)photo {
    if (!_photo) {
        _photo = [LTCellModel initWith:@"头像" des:@"" placeholder:@"请填写" type: LTNormal];
    }
    return _photo;
}

- (LTCellModel *)name {
    if (!_name) {
        _name = [LTCellModel initWith:@"姓名" des:@"" placeholder:@"请填写" type: LTSelected];
    }
    return _name;
}

- (LTCellModel *)sex {
    if (!_sex) {
        _sex = [LTCellModel initWith:@"性别" des:@"" placeholder:@"请选择" type: LTSelected];
    }
    return _sex;
}


- (LTCellModel *)job {
    if (!_job) {
        _job = [LTCellModel initWith:@"我的职位" des:@"" placeholder:@"请填写" type: LTSelected];
    }
    return _job;
}


- (LTCellModel *)store {
    if (!_store) {
        _store = [LTCellModel initWith:@"添加店铺" des:@"" placeholder:@"请添加" type: LTSelected];
    }
    return _store;
}

- (LTCellModel *)tel {
    if (!_tel) {
        _tel = [LTCellModel initWith:@"手机号" des:@"" placeholder:@"请填写" type: LTSelected];
    }
    return _tel;
}

- (LTCellModel *)wx {
    if (!_wx) {
        _wx = [LTCellModel initWith:@"微信号" des:@"" placeholder:@"请选择" type: LTSelected];
    }
    return _wx;
}

- (LTCellModel *)home {
    if (!_home) {
        _home = [LTCellModel initWith:@"家乡" des:@"" placeholder:@"请填写" type: LTSelected];
    }
    return _home;
}

- (UserInfoModel *)model {
    if (!_model) {
        _model = [[UserInfoModel alloc]init];
    }
    return _model;
}

- (void)requestGetMineInfo:(void(^)(BOOL success))complete {
    self.model = UserManager.share.infoModel;
    self.name.des = self.model.name;
    self.photo.des = self.model.photourl;
    self.sex.des = self.model.sex;
    self.tel.des = self.model.mobile;
    self.wx.des = self.model.wechat;
    if (self.model.provincename && self.model.cityname) {
        self.home.des = [NSString stringWithFormat:@"%@-%@", self.model.provincename?:@"", self.model.cityname?:@""];
    }
}


- (void)requestSaveMinInfo:(void(^)(BOOL success))complete {
    NSDictionary *params = @{@"photo": self.model.photourl?:@"",
                             @"name": self.model.name?:@"",
                             @"sex":self.model.sex?:@"",
                             @"mobile": self.model.mobile?:@"",
                             @"wechat":self.model.wechat?:@"",
                             @"provincecode":self.model.provincecode?:@"",
                             @"citycode":self.model.citycode?:@""};
    [NetworkManager sendReq:params pageUrl:XY_B_saveuserrecruiter complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count) {
            NSDictionary *dict = arr.firstObject;
            self.model = [UserInfoModel yy_modelWithJSON:dict];
            self.name.des = self.model.name;
            self.photo.des = self.model.photourl;
            self.sex.des = self.model.sex;
        }
        complete(YES);
    }];
}

- (void)requestStoreList:(void(^)(BOOL success))complete {
    NSDictionary *dict = @{@"pageNum":@"1", @"pageSize":@"20"};
    
    [NetworkManager sendReq:dict pageUrl:XY_B_shoplist isLoading:NO complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            self.storeManagerModel = [BMStoreManagerModel yy_modelWithJSON:arr.firstObject];
        }
        complete(YES);
    } failure:^(NSInteger code, NSString *msg) {
        complete(NO);
    }];
}

@end
