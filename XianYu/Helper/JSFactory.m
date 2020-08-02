//
//  JSFactory.m
//  XinBianLi
//
//  Created by lmh on 2017/10/10.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import "JSFactory.h"
#import <Masonry.h>
#import <AFNetworking.h>
#import <IQKeyboardManager.h>
#import <MJRefresh.h>
#import <UIView+WebCache.h>





@implementation JSFactory

+ (int)sendString:(NSString *)string strFont:(CGFloat)strFont strSize:(CGSize)strSize
{
    CGRect rect1 = [@"哈哈哈哈" boundingRectWithSize:strSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:strFont]} context:nil];
    CGRect rect = [string boundingRectWithSize:strSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:strFont]} context:nil];
    int count = (int)rect.size.height/rect1.size.height;
    return count;
}

+ (UITableView *)creatTabbleViewWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    UITableView * tabview = [[UITableView alloc]initWithFrame:frame style:style];
    tabview.showsVerticalScrollIndicator = NO;
    tabview.showsHorizontalScrollIndicator = NO;
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabview.backgroundColor = [UIColor clearColor];
    return tabview;
}

+ (UILabel *)creatLabelWithTitle:(NSString *)title textColor:(UIColor *)textColor textFont:(CGFloat)fontValue textAlignment:(NSTextAlignment)alignment {
    UILabel * label = [[UILabel alloc]init];
    label.text = title;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontValue];
    label.textAlignment = alignment;
    return label;
}

+ (UIButton *)creatButtonWithTitle:(NSString *)title textFont:(CGFloat)textFontVlaue titleColor:(UIColor *)titleColor backGroundColor:(UIColor *)backGroundColor{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:textFontVlaue];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:backGroundColor];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)creatButtonWithNormalImage:(NSString *)normalImage selectImage:(NSString *)selectImage{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    if (selectImage != nil) {
        [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    }
    return button;
}

+ (UIView *)creatViewWithColor:(UIColor *)color{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = color;
    return view;
}

+ (UIImageView *)creatImageViewWithImageName:(NSString *)image{
    UIImageView * imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:image]];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    return imgView;
}

+ (UIImageView *)createArrowImageView
{

    return [JSFactory creatImageViewWithImageName:@"icon_arrow_right"];
}

+ (UIView *)createLineView
{
    return [JSFactory creatViewWithColor:Color_Line_EBEBEB];
}

+ (UITextField *)creatTextFieldWithPlaceHolder:(NSString *)placeHolder textAlignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor textFont:(CGFloat)textFont{
    UITextField * textfield = [[UITextField alloc]init];
    textfield.placeholder = placeHolder;
    textfield.textAlignment = alignment;
#warning 设置颜色
//    textfield.tintColor = Color_Black_464646;
    textfield.textColor = textColor;
    textfield.font = [UIFont systemFontOfSize:textFont];
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    textfield.leftView = whiteView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    return textfield;
}

+ (void)callPhoneStr:(NSString*)phoneStr withVC:(UIViewController *)selfvc{
    if (phoneStr.length >= 10) {
        NSString *str2 = [[UIDevice currentDevice] systemVersion];
        if ([str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedDescending || [str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedSame)
        {
            NSString* PhoneStr = [NSString stringWithFormat:@"telprompt://%@",phoneStr];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PhoneStr] options:@{} completionHandler:^(BOOL success) {
                NSLog(@"phone success");
            }];
            
        }else {
            NSMutableString* str1 = [[NSMutableString alloc]initWithString:phoneStr];// 存在堆区，可变字符串
            if (phoneStr.length == 10) {
                [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
                [str1 insertString:@"-"atIndex:7];// 把一个字符串插入另一个字符串中的某一个位置
            }else {
                [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
                [str1 insertString:@"-"atIndex:8];// 把一个字符串插入另一个字符串中的某一个位置
            }
            NSString * str = [NSString stringWithFormat:@"是否拨打电话\n%@",str1];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message: nil preferredStyle:UIAlertControllerStyleAlert];
            // 设置popover指向的item
            alert.popoverPresentationController.barButtonItem = selfvc.navigationItem.leftBarButtonItem;
            // 添加按钮
            [alert addAction:[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                NSLog(@"点击了呼叫按钮10.2下");
                NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",phoneStr];
                if ([PhoneStr hasPrefix:@"sms:"] || [PhoneStr hasPrefix:@"tel:"]) {
                    UIApplication * app = [UIApplication sharedApplication];
                    if ([app canOpenURL:[NSURL URLWithString:PhoneStr]]) {
                        [app openURL:[NSURL URLWithString:PhoneStr]];
                    }
                }
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击了取消按钮");
            }]];
            [selfvc presentViewController:alert animated:YES completion:nil];
        }
    }
}

+ (NSData *)dealWithAvatarImage:(UIImage *)avatarImage{
    CGSize avatarSize = avatarImage.size;
    CGSize newSize = CGSizeMake(640, 640);
    //尺寸压缩
    if (avatarSize.width <= newSize.width && avatarSize.height <= newSize.height) {
        newSize = avatarSize;
    }
    else if (avatarSize.width > newSize.width && avatarSize.height > newSize.height) {
        CGFloat tempLength = avatarSize.width > avatarSize.height ?  avatarSize.width : avatarSize.height;
        CGFloat rate = tempLength / newSize.width;
        newSize.width = avatarSize.width / rate;
        newSize.height = avatarSize.height / rate;
    }
    else if (avatarSize.width > newSize.width) {
        newSize.height = avatarSize.height * newSize.width / avatarSize.width;
    }
    else {
        avatarSize.width = avatarSize.width * newSize.height / avatarSize.height;
    }
    UIImage *avatarNew = [[JSFactory new] imageWithImage:avatarImage scaledToSize:newSize];
    NSData *data = UIImageJPEGRepresentation(avatarNew, 1);
//    UIImagePNGRepresentation(avatarImage);
    
    return data;
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (void)configureWithView:(UIView *)borderView cornerRadius:(CGFloat)cornerRadius isBorder:(BOOL)border borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    borderView.layer.cornerRadius = cornerRadius;
    borderView.layer.masksToBounds = YES;
//    [borderView ff_setCornerType:(UIRectCornerAllCorners) cornerRadius:cornerRadius];
    if (border) {
        borderView.layer.borderWidth = borderWidth;
        borderView.layer.borderColor = borderColor.CGColor;
    }
    else
    {
        borderView.layer.borderWidth = 0;
    }
    borderView.layer.shouldRasterize = YES;
    borderView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}


/**
 get text size
 */
+ (CGSize)getSize:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont*)font{
    CGSize sizeFirst = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
    return sizeFirst;
}
+ (CGSize)getSize:(NSMutableAttributedString *)attributes maxSize:(CGSize)maxSize{
    CGSize attSize = [attributes boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    return attSize;
}







+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController*)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[((UINavigationController*) vc) visibleViewController]];
    }else if ([vc isKindOfClass:[UITabBarController class]]){
        return [self getVisibleViewControllerFrom:[((UITabBarController*) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}


+ (NSString *)removeSpaceAndNewline:(NSString *)str {
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

+ (BOOL)isEqualToNil:(NSString *)str {
    return str.length <= 0 || [str isEqualToString:@""] || !str;
}


//获取当前view所在视图控制器
+ (UIViewController *)belongViewController:(UIView *)childView {
    for (UIView *next = [childView superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


+(UIImage*) createImageWithColor:(UIColor*)color withBounds:(CGRect)bounds
{
    CGRect rect=bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


//投影
+ (void)setCornerBlueIndex:(CGFloat)cornerIndex cornerView:(UIView *)view isShow:(BOOL)isShow shadowIndex:(CGFloat)shadowIndex  shadColor:(CGFloat)colorAlpha
{
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = shadowIndex;
    view.layer.shadowColor = UIColorFromRGBA(0x929292, colorAlpha).CGColor;
    view.layer.shadowOpacity = 1;
    view.layer.cornerRadius = cornerIndex;
    if (isShow) {
        [view.layer setShadowPath:[[UIBezierPath
                                    bezierPathWithRect:view.bounds] CGPath]];
    }
}

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}


#pragma mark ------------- 有赏 -----------
+ (NSTimeInterval)setTimeWithNum:(NSNumber *)startTimeStr withEndTimerStr:(NSNumber *)endTimeStr{
    NSInteger numTime = [endTimeStr integerValue];
    NSInteger nowTime = [startTimeStr integerValue];
    
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:numTime];
    NSDate *stampDate3 = [NSDate dateWithTimeIntervalSince1970:nowTime];
    NSTimeInterval timeIn = [stampDate2 timeIntervalSinceDate:stampDate3];
    return timeIn;
}

+(NSArray *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    int day = [str_hour intValue] / 24;
    if (day > 1) {
        int hour = [str_hour intValue] - day*24;
        str_hour = [NSString stringWithFormat:@"%02d",hour];
        format_time = [NSString stringWithFormat:@"%d天 %@小时 %@分 %@秒",day,str_hour,str_minute,str_second];
    }
    else
    {
        format_time = [NSString stringWithFormat:@"%@小时 %@分 %@秒",str_hour,str_minute,str_second];
    }
    NSMutableArray *dateArray = [NSMutableArray array];
    [dateArray addObject:[NSString stringWithFormat:@"%d",day]];
    [dateArray addObject:str_hour];
    [dateArray addObject:str_minute];
    [dateArray addObject:str_second];
    
    
    return dateArray;
    
}


+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSLog(@"1296035591  = %@",confromTimesp);
    
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    
    
    return confromTimespStr;
    
}








@end
