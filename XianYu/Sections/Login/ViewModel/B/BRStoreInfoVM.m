//
//  BRStoreInfoVM.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRStoreInfoVM.h"

@implementation BRStoreInfoVM

@synthesize fromeType = _fromeType;

- (void)setFromeType:(NSInteger)fromeType {
    _fromeType = fromeType;
    if (self.fromeType == 0) {
        self.dataSource = @[self.storeNm, self.branchStoreNm, self.storeAdd, self.employerCount, self.trade, self.myJob];
    } else {
        self.dataSource = @[self.photo, self.storeNm, self.branchStoreNm, self.storeAdd, self.employerCount, self.trade, self.storeDes, self.myJob, self.status, ];
    }
    if (self.fromeType == 2) {
        for (LTCellModel *model in self.dataSource) {
            model.type = LTDisable;
        }
    }
}

- (NSInteger)fromeType {
    if (!_fromeType) {
        _fromeType = 0;
    }
    return _fromeType;
}

- (NSArray<LTCellModel*> *)dataSource {
    if (!_dataSource) {
        _dataSource = @[self.storeNm, self.branchStoreNm, self.storeAdd, self.employerCount, self.trade, self.myJob];
    }
    return _dataSource;
}

- (NSArray *)imgs {
    if (!_imgs) {
        _imgs = [NSArray array];
    }
    return _imgs;
}

- (LTCellModel *)photo {
    if (!_photo) {
        _photo = [LTCellModel initWith:@"门店LOGO" des:@"" placeholder:@"请填写" type: LTNormal];
    }
    return _photo;
}

- (LTCellModel *)storeNm {
    if (!_storeNm) {
        _storeNm = [LTCellModel initWith:@"门店名称" des:@"" placeholder:@"请填写" type: LTSelected];
    }
    return _storeNm;
}

- (LTCellModel *)branchStoreNm {
    if (!_branchStoreNm) {
        _branchStoreNm = [LTCellModel initWith:@"分店名称" des:@"" placeholder:@"请填写" type: LTSelected];
    }
    return _branchStoreNm;
}

- (LTCellModel *)storeAdd {
    if (!_storeAdd) {
        _storeAdd = [LTCellModel initWith:@"门店地址" des:@"" placeholder:@"请填写详细地址" type: LTSelected];
    }
    return _storeAdd;
}


- (LTCellModel *)employerCount {
    if (!_employerCount) {
        _employerCount = [LTCellModel initWith:@"人员规模" des:@"" placeholder:@"请选择" type: LTSelected];
    }
    return _employerCount;
}


- (LTCellModel *)trade {
    if (!_trade) {
        _trade = [LTCellModel initWith:@"所属行业" des:@"" placeholder:@"请选择" type: LTSelected];
    }
    return _trade;
}

- (LTCellModel *)storeDes {
    if (!_storeDes) {
        _storeDes = [LTCellModel initWith:@"店铺简介" des:@"" placeholder:@"填写店铺简介,增加招人成功率" type: LTSelected];
    }
    return _storeDes;
}


- (LTCellModel *)myJob {
    if (!_myJob) {
        _myJob = [LTCellModel initWith:@"我的职位" des:@"" placeholder:@"请填写" type: LTSelected];
    }
    return _myJob;
}


- (LTCellModel *)status {
    if (!_status) {
        _status = [LTCellModel initWith:@"认证状态" des:@"" placeholder:@"未认证" type: LTSelected];
    }
    return _status;
}

- (BRStoreInfoModel *)storeInfo {
    if (!_storeInfo) {
        _storeInfo = [[BRStoreInfoModel alloc]init];
    }
    return _storeInfo;
}

- (BRTradeModel *)tradeModel {
    if (!_tradeModel) {
        _tradeModel = [[BRTradeModel alloc]init];
    }
    return _tradeModel;
}

- (BOOL)checkParams {
    if (self.storeNm.des.length == 0) {
        [ToastView show:@"请填写门店名称"];
        return NO;
    }
    if (self.branchStoreNm.des.length == 0) {
        [ToastView show:@"请填写分店名称"];
        return NO;
    }
    if (self.employerCount.des.length == 0) {
        [ToastView show:@"请选择人员规模"];
        return NO;
    }
    if (self.tradeModel.id.length == 0) {
        [ToastView show:@"请选择所属行业"];
        return NO;
    }
    if (self.myJob.des.length == 0) {
        [ToastView show:@"请填写我的职位"];
        return NO;
    }
    return YES;
}

- (void)configStoreInfo {
    self.storeInfo.shopname = self.storeNm.des;
    self.storeInfo.idenname = self.branchStoreNm.des;
    self.storeInfo.address = self.addressModel.address;
    self.storeInfo.addressid = self.addressModel.id;
    self.storeInfo.scale = self.employerCount.des;
    self.storeInfo.industry = self.tradeModel.name;
    self.storeInfo.industryid = self.tradeModel.id;
    self.storeInfo.introduction = self.storeDes.des;
    self.storeInfo.position = self.myJob.des;
    self.storeInfo.logo = self.photo.des;
    self.storeInfo.environmentimgs = [self.imgs componentsJoinedByString:@","];
}

- (void)requestSaveStore:(void(^)(BOOL success))complete {
    if (![self checkParams]) {
        return;
    }
    [self configStoreInfo];
    NSDictionary *params = @{@"id":self.storeInfo.id,
                             @"logo":self.storeInfo.logo,
                             @"position":self.storeInfo.position,
                             @"shopname":self.storeInfo.shopname,
                             @"idenname":self.storeInfo.idenname,
                             @"addressid": self.storeInfo.addressid ?: @"",
                             @"industryid":self.storeInfo.industryid,
                             @"scale":self.storeInfo.scale,
                             @"introduction":self.storeInfo.introduction,
                             @"environmentimgs":self.storeInfo.environmentimgs
    };
    [NetworkManager sendReq:params pageUrl:XY_B_saveshop complete:^(id result) {
        complete(YES);
    }];
}

- (void)requestGetStoreInfo:(void(^)(BOOL success))complete {
    if (!self.storeInfo.id) {
        return;
    }
    NSDictionary *params = @{@"id": self.storeInfo.id};
    [NetworkManager sendReq:params pageUrl:XY_B_getshop complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            NSDictionary *dict = arr.firstObject;
            self.storeInfo = [BRStoreInfoModel yy_modelWithJSON:dict];
            self.photo.des = self.storeInfo.logo;
            self.storeNm.des = self.storeInfo.shopname;
            self.branchStoreNm.des = self.storeInfo.idenname;
            self.storeAdd.des = self.storeInfo.address;
            self.employerCount.des = self.storeInfo.scale;
            self.trade.des = self.storeInfo.industry;
            self.storeDes.des = self.storeInfo.introduction;
            self.myJob.des = self.storeInfo.position;
            self.tradeModel.id = self.storeInfo.industryid;
            self.tradeModel.name = self.storeInfo.industry;
            self.status.des = [self.storeInfo.auditstatus isEqualToString:@"1"] ? @"已认证" : @"未认证";
            self.imgs = [self.storeInfo.environmentimgs componentsSeparatedByString:@","];
        }
        
        complete(YES);
    }];
}


@end
