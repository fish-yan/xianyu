//
//  JSFactory.h
//  XinBianLi
//
//  Created by lmh on 2017/10/10.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface JSFactory : NSObject

+ (UITableView *)creatTabbleViewWithFrame:(CGRect)frame style:(UITableViewStyle)style;

+ (UILabel *)creatLabelWithTitle:(NSString *)title textColor:(UIColor *)textColor textFont:(CGFloat)fontValue textAlignment:(NSTextAlignment)alignment;

+ (UIButton *)creatButtonWithTitle:(NSString *)title textFont:(CGFloat)textFontVlaue titleColor:(UIColor *)titleColor backGroundColor:(UIColor *)backGroundColor;

+ (UIImageView *)createArrowImageView;

+ (UIView *)createLineView;

+ (UIButton *)creatButtonWithNormalImage:(NSString *)normalImage selectImage:(NSString *)selectImage;

+ (UIView *)creatViewWithColor:(UIColor *)color;

+ (UIImageView *)creatImageViewWithImageName:(NSString *)image;

+ (UITextField *)creatTextFieldWithPlaceHolder:(NSString *)placeHolder textAlignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor textFont:(CGFloat)textFont;

+ (void)callPhoneStr:(NSString*)phoneStr withVC:(UIViewController *)selfvc;

+ (int)sendString:(NSString *)string strFont:(CGFloat)strFont strSize:(CGSize)strSize;

+ (NSData *)dealWithAvatarImage:(UIImage *)avatarImage;

+ (void)configureWith:(UIImageView *)imageView;

+ (void)configureWithView:(UIView *)borderView cornerRadius:(CGFloat)cornerRadius isBorder:(BOOL)border borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (CGSize)getSize:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont*)font;

+ (CGSize)getSize:(NSMutableAttributedString *)attributes maxSize:(CGSize)maxSize;

//拿到当前正在显示的控制器，不管是push进去的，还是present进去的都能拿到
+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController*)vc;

//移除字符串中的空格和换行
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

//字符串是否为空
+ (BOOL)isEqualToNil:(NSString *)str;

//获取当前view所在视图控制器
+ (UIViewController *)belongViewController:(UIView *)childView;

//将颜色转为图片
+(UIImage*) createImageWithColor:(UIColor*)color withBounds:(CGRect)bounds;

//投影
+ (void)setCornerBlueIndex:(CGFloat)cornerIndex cornerView:(UIView *)view isShow:(BOOL)isShow shadowIndex:(CGFloat)shadowIndex  shadColor:(CGFloat)colorAlpha;

+(NSString *)convertToJsonData:(NSDictionary *)dict;

#pragma mark ----------------- 有赏 -----------
+(NSString *)getMMSSFromSS:(NSString *)totalTime;
+ (NSTimeInterval)setTimeWithNum:(NSNumber *)startTimeStr withEndTimerStr:(NSNumber *)endTimeStr;
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

@end
