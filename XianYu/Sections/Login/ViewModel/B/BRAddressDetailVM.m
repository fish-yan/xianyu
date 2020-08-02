//
//  BRAddressDetailVM.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BRAddressDetailVM.h"

@implementation BRAddressDetailVM

- (BRAddressModel *)model {
    if (!_model) {
        _model = [[BRAddressModel alloc]init];
    }
    return _model;
}

- (NSArray<LTCellModel*> *)dataSource {
    if (!_dataSource) {
        _dataSource = @[self.add, self.addDetail];
    }
    return _dataSource;
}

- (LTCellModel *)add {
    if (!_add) {
        _add = [LTCellModel initWith:@"所在地区" des:@"" placeholder:@"省市区选择" type: LTSelected];
    }
    return _add;
}

- (LTCellModel *)addDetail {
    if (!_addDetail) {
        _addDetail = [LTCellModel initWith:@"详细地址" des:@"" placeholder:@"" type: LTDisable];
    }
    return _addDetail;
}

- (void)requestAddAddress:(void(^)(BOOL success))complete {
    if (![self checkParams]) {
        return;
    }
    NSDictionary *params = @{@"id":self.model.id ?: @"", @"provincecode":self.model.provincecode, @"citycode":self.model.citycode, @"towncode":self.model.towncode, @"address":self.model.address, @"lon":[NSString stringWithFormat:@"%f", UserManager.share.longitude], @"lad":[NSString stringWithFormat:@"%f", UserManager.share.latitude]};
    [NetworkManager sendReq:params pageUrl:XY_B_saveaddress complete:^(id result) {
        complete(YES);
    }];
}

- (BOOL)checkParams {
    if (self.model.provincecode.length == 0 ||
        self.model.citycode.length == 0 ||
        self.model.towncode.length == 0)
    {
        [ToastView show:@"请选择省市区"];
        return NO;
    }
    if (self.model.address.length == 0) {
        [ToastView show:@"请填写详细地址"];
        return NO;
    }
    return YES;
}

@end
