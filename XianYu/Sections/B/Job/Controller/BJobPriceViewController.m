//
//  BJobPutUpViewController.m
//  XianYu
//
//  Created by Yan on 2019/7/23.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "BJobPriceViewController.h"
#import "BJobPriceCell.h"
#import "BJobPriceModel.h"
#import "BJobPayResultViewController.h"
#import "B_BuyPackageModel.h"
#import "BJobListViewController.h"
#import "BJobDetailViewController.h"
#import "BMineViewController.h"
#import "BTaocanCard.h"

@interface BJobPriceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) NSMutableArray<BJobPriceModel*> *dataSource;
@property (strong, nonatomic) BJobPriceModel *selectedModel;
@property (copy, nonatomic) NSString *orderId;

@property (copy, nonatomic) NSString *stauts;
@property (copy, nonatomic) NSString *znum; // 可认证次数
@property (copy, nonatomic) NSString *snum; // 剩余次数
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentH;

@property (strong, nonatomic) NSMutableArray<BTaocanCard *> *cardVs;

@property (nonatomic, assign) BOOL isPushed;

@end

@implementation BJobPriceViewController

- (BOOL)isFirst {
    if (_isFirst) {
        _isFirst = NO;
    }
    return _isFirst;
}

- (NSMutableArray<BJobPriceModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    self.isPushed = NO;
    self.contentV.alpha = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentV.alpha = 0;
    [self request];
}

- (void)initView {
    self.contentH.constant = 80 * self.dataSource.count + 120;
    self.cardVs = [NSMutableArray array];
    int i = 0;
    for (BJobPriceModel *m in self.dataSource) {
        BTaocanCard *v = [BTaocanCard new];
        v.tag = i;
        v.model = m;
        [self.contentV addSubview:v];
        [self.cardVs addObject:v];
        v.btnAction = ^(BTaocanCard * _Nonnull someV) {
            [self reload:someV.tag];
            self.selectedModel = someV.model;
        };
        i++;
    }
    [self reload:0];
    
}

- (void)reload:(NSInteger)index {
    CGFloat y = 0;
    NSInteger i = 0;
    for (BTaocanCard *v in self.cardVs) {
        CGFloat height = i == index ? 200 : 80;
        v.isSelected = i == index;
        [UIView animateWithDuration:0.25 animations:^{
            v.frame = CGRectMake(0, y, KScreenWidth, height);
        }];
        y += height;
        i++;
    }
}

- (void)request {
    NSDictionary *params = @{@"type":@"3"};
    [NetworkManager sendReq:params pageUrl:XY_B_getmemerservices complete:^(id result) {
        NSArray *arr = result[@"data"];
        self.dataSource = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            BJobPriceModel *model = [BJobPriceModel yy_modelWithJSON:dict];
            [self.dataSource addObject:model];
        }
        self.selectedModel = self.dataSource.firstObject;
        [self initView];
    }];
    [NetworkManager sendReq:nil pageUrl:XY_B_myservice complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            if ([self.navigationController.viewControllers.firstObject isKindOfClass:[BMineViewController class]]) {
                self.dateLab.text = arr.firstObject[@"service"];
            } else {
                self.dateLab.text = @"";
            }
        }
    }];
}

- (IBAction)commitAction:(UIButton *)sender {
    if (!self.selectedModel) {
        [ToastView show:@"请选择套餐"];
        return;
    }
    [self requestOrderId];
}

- (IBAction)protoAction:(UIButton *)sender {
    [NetworkManager sendReq:@{@"k":@"zengzhi.xieyi"} pageUrl:@"getv" complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            NSString *str = @"";
            if (arr.firstObject != [NSNull null]) {
                str = arr.firstObject;
            }
            if (str.length == 0) {
                [ToastView show:@"url 为空"];
                return ;
            }
            WKWebViewController *webVC = [[WKWebViewController alloc]initWithUrl:[NSURL URLWithString:str]];
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }];
    
}

- (void)requestOrderId {
    if (self.selectedModel.no == nil) {
        [ToastView show:@"套餐编号为空"];
        return;
    }
    NSDictionary *params = @{@"no":self.selectedModel.no};
    [NetworkManager sendReq:params pageUrl:XY_B_rechargememeservicebyapple complete:^(id result) {
        NSString *str = [result[@"data"] firstObject];
        self.orderId = str;
        [self iosPay];
    }];
}

- (void)iosPay {
    [[B_BuyPackageModel shareInstance] requestProductData:self.selectedModel.no withOrderID:self.orderId];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestPayResult) name:@"App_RefreshBuy_Hunter" object:nil];
}

- (void)requestPayResult {
    [self checkAuth];
}

- (void)checkAuth {
    [NetworkManager sendReq:nil pageUrl:XY_B_userfacestatus complete:^(id result) {
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            NSDictionary *dict = arr.firstObject;
            self.stauts = dict[@"stauts"];
            self.znum = dict[@"znum"];
            self.snum = dict[@"snum"];
            if (self.isPushed) {
                return;
            }
            if (self.isFirst) {
                [UserManager.share switchClient:XYB complete:^{
                    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
                    UIApplication.sharedApplication.keyWindow.rootViewController = vc;
                }];
            } else {
               [self performSegueWithIdentifier:@"BJobPayResult" sender:nil];
            }
            self.isPushed = YES;
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BJobPayResult"]) {
        BJobPayResultViewController *vc = segue.destinationViewController;
        vc.stauts = self.stauts;
        vc.znum = self.znum;
        vc.snum = self.snum;
    }
}

@end
