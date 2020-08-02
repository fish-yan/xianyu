//
//  C_MapViewController.m
//  New_MeiChai
//
//  Created by lmh on 2018/6/1.
//  Copyright © 2018年 lmh. All rights reserved.
//

#import "C_MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface C_MapViewController ()<AMapSearchDelegate,MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *searchApi;

@property (nonatomic, strong) AMapGeoPoint *locationPoint;

@property (nonatomic, copy) NSString *addStr;

@end

@implementation C_MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitle:@"工作地址" titleColor:color andNavColor:Color_White];
    [self setNavTitle:@"位置" titleColor:Color_Black_464646 andNavColor:Color_White];
    [self createNavRightItem:@"导航" withStrColor:Color_Black_464646 itemImageStr:nil withIsEnable:YES];
    [self drawBackButtonWithBlackStatus:NavigationBackType_Black];
    [self createMapView];
    [self createBottomView];
    [self switchLocationString:self.addressName];
    
    // Do any additional setup after loading the view.
}

- (void)clickOneRightNavBarItem
{
    [self clickGoButton];
}

- (void)createMapView
{
    [AMapServices sharedServices].enableHTTPS = YES;
    //初始化地图
    self.mapView = [[MAMapView alloc]initWithFrame:(CGRectMake(0, 0, KScreenWidth, KScreenHeight - Anno750(100)))];
    self.mapView.zoomLevel = 15;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
//    self.mapView.showsUserLocation = NO;
//    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    
//
//    UIButton *goButton = [JSFactory creatButtonWithNormalImage:@"icon_map_roadline" selectImage:@"icon_map_roadline"];
//
//    [goButton addTarget:self action:@selector(clickGoButton) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:goButton];
//    [goButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(@(-Anno750(24)));
//        make.bottom.equalTo(@(-Anno750(140)));
//        make.size.mas_equalTo(CGSizeMake(Anno750(100), Anno750(100)));
//    }];
}

- (void)createBottomView
{
    UIView *bottomView = [JSFactory creatViewWithColor:Color_White];
    bottomView.frame = CGRectMake(0, KScreenHeight - Anno750(100), KScreenWidth, Anno750(100));
    [self.view addSubview:bottomView];
    UIImageView *imageView = [JSFactory creatImageViewWithImageName:nil];
    UIButton *copyButton = [JSFactory creatButtonWithTitle:@"复制地址" textFont:font750(28) titleColor:UIColorFromRGB(0xFF5F5F) backGroundColor:Color_White];
    [copyButton addTarget:self action:@selector(clickCopyButton) forControlEvents:(UIControlEventTouchUpInside)];
    UILabel *addressLabel = [JSFactory creatLabelWithTitle:@"" textColor:Color_Black_A5A5A5 textFont:font750(28) textAlignment:(NSTextAlignmentLeft)];
    [addressLabel setLabelSpaceAlign:(NSTextAlignmentLeft) withValue:self.addressName withFont:font750(28) withLineSpace:font750(12)];
    addressLabel.numberOfLines = 2;
    [bottomView addSubview:imageView];
    [bottomView addSubview:copyButton];
    [bottomView addSubview:addressLabel];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.left.equalTo(@(Anno750(24)));
        make.size.mas_equalTo(CGSizeMake(Anno750(30), Anno750(30)));
    }];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.equalTo(bottomView);
        make.bottom.equalTo(bottomView);
        make.width.equalTo(@(Anno750(150)));
    }];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView);
        make.bottom.equalTo(bottomView);
        make.left.equalTo(imageView.mas_right).offset(Anno750(10));
        make.right.equalTo(copyButton.mas_left).offset(-Anno750(10));
    }];
}

- (void)clickCopyButton
{
    UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
    pastboard.string = self.addressName;
    [ToastView presentToastWithin:self.view withIcon:(APToastIconNone) text:@"已复制到剪贴板" duration:2.0f];
}
- (CLLocationCoordinate2D)switchLocationAddress:(AMapCoordinateType)type
{
    CLLocationCoordinate2D amapcoord = AMapCoordinateConvert(CLLocationCoordinate2DMake(self.locationPoint.latitude,self.locationPoint.longitude), type);
    return amapcoord;
}

- (void)switchLocationString:(NSString *)str
{
    
    if ([str containsString:@"|"]) {
        self.addStr = [str stringByReplacingOccurrencesOfString:@"|" withString:@""];
    }
    self.searchApi = [[AMapSearchAPI alloc]init];
    self.searchApi.delegate = self;
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc]init];
    geo.address = self.addStr;
    [self.searchApi AMapGeocodeSearch:geo];
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
//    NSLog(@"-----------");
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0) {
        return;
    }
    AMapGeocode *code = [response.geocodes firstObject];
    self.locationPoint = code.location;
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(code.location.latitude, code.location.longitude) animated:YES];
    
    MAPointAnnotation *al = [[MAPointAnnotation alloc]init];
    al.coordinate = CLLocationCoordinate2DMake(self.locationPoint.latitude, self.locationPoint.longitude);
    [self.mapView addAnnotation:al];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

- (void)clickGoButton
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"高德地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        CLLocationCoordinate2D location = [self switchLocationAddress:AMapCoordinateTypeAMap];
        [self opneGaodeMap:location];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"百度地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        CLLocationCoordinate2D location = [self switchLocationAddress:AMapCoordinateTypeBaidu];
        [self openBaiduMap:location];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"腾讯地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        CLLocationCoordinate2D location = [self switchLocationAddress:AMapCoordinateTypeSoSoMap];
        [self openTengXunMap:location];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [alertVC addAction:action4];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    [self switchLocationString:self.addressName];
}

- (void)opneGaodeMap:(CLLocationCoordinate2D)location
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSString *str1 = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=1",location.latitude, location.longitude,self.addStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str1]];
    }
}

- (void)openBaiduMap:(CLLocationCoordinate2D)location
{
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?&destination=%f,%f&mode=transit&src=webapp.navi.yourCompanyName.yourAppName",location.latitude, location.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];

    }
}

- (void)openTengXunMap:(CLLocationCoordinate2D)location
{
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
      NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=%@&coord_type=1&policy=0&type=bus",location.latitude, location.longitude,self.addStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
