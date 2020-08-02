//
//  ToastView.m
//  lemon
//
//  Created by 吴孔锐 on 16/8/16.
//  Copyright © 2016年 youdaofinancial. All rights reserved.
//

#import "ToastView.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/message.h>
#import "ToastViewDelegate.h"
#define APCommonUILoadImage(imageName) \
[UIImage imageNamed:imageName]

#define APCommonUIGetSystemVersion() \
([[[UIDevice currentDevice] systemVersion] floatValue])

#define APCommonUIIsIphone6Plus \
(CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736)))

@interface UIWindow (ToastView)

// window所包含的所有toast
// 时间序
@property (nonatomic, readonly) NSMutableArray *toastStack;

@end
@interface ToastView () {
    APToastIcon _iconType;
    UIView      *_iconView;
    UILabel     *_textLabel;
}
@property (nonatomic, assign) NSTimeInterval second;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView *backgoundView;
@property (nonatomic, copy) void (^completion)();
//for 自动化测试
@property (nonatomic, strong) id<ToastDelegate>toastDelegate;

// 被相关toast覆盖的次数
// 如个两个toast(或其backgroundView)的superview相同或有父子关系, 提其相关, 晚出的影响早出的suppressCount
// 当suppressCount大于0时, toast隐藏
@property(nonatomic, assign) int suppressCount;
/**
 *  toast显示前存在的ToastView
 */
@property (nonatomic, strong) UIView *keyboardView;

@end


@implementation ToastView

+ (ToastView *)show:(NSString *)text {
    UIView *oneView = [UIViewController visibleViewController].view;
    return [self presentToastWithin:oneView withIcon:APToastIconNone text:text duration:1];
}

+ (ToastView *)presentToastWithin:(UIView *)superview withIcon:(APToastIcon)icon text:(NSString *)text duration:(NSTimeInterval)duration
{
    return [self presentToastWithin:superview
                           withIcon:icon
                               text:text
                           duration:duration
                         completion:NULL];
}
+ (ToastView *)presentToastWithin:(UIView *)superview withIcon:(APToastIcon)icon text:(NSString *)text duration:(NSTimeInterval)duration completion:(void (^)())completion
{
    
    return [self presentToastWithin:superview
                           withIcon:icon
                               text:text
                           duration:duration
                              delay:0
                         completion:completion];
}
+ (ToastView *)presentToastWithin:(UIView *)superview
                           withIcon:(APToastIcon)icon
                               text:(NSString *)text
                           duration:(NSTimeInterval)duration
                              delay:(NSTimeInterval)delay
                         completion:(void (^)())completion
{
    if (!text || text.length == 0) {
        return nil;
    }
    ToastView *toast = [[ToastView alloc] initWithText:text toastType:icon];

    toast.second = duration;
    toast.completion = completion;
    [superview addSubview:toast];
    
    if (delay > 0) {
        toast.hidden = YES;
        [toast performSelector:@selector(showDelayedToast) withObject:nil afterDelay:delay];
    } else {
        [toast pushToStack];
        [toast showToast];
    }
    return toast;
}
+ (ToastView *)presentModalToastWithin:(UIView *)superview
                                withIcon:(APToastIcon)icon
                                    text:(NSString *)text
                                duration:(NSTimeInterval)duration
                              completion:(void (^)())completion
{
    return [self presentModalToastWithin:superview withIcon:icon text:text duration:duration delay:0 completion:completion];
}

+ (ToastView *)presentModalToastWithin:(UIView *)superview
                                withIcon:(APToastIcon)icon
                                    text:(NSString *)text
                                duration:(NSTimeInterval)duration
                                   delay:(NSTimeInterval)delay
                              completion:(void (^)())completion
{
    ToastView *toast = [[ToastView alloc] initWithText:text toastType:icon];
    toast.second = duration;
    toast.completion = completion;
    UIView *backgroundView = [[UIView alloc] initWithFrame:superview.bounds];
    [superview addSubview:backgroundView];
    [backgroundView addSubview:toast];
    toast.backgoundView = backgroundView;
    
    if (delay > 0) {
        toast.hidden = YES;
        [toast performSelector:@selector(showDelayedToast) withObject:nil afterDelay:delay];
    } else {
        [toast pushToStack];
        [toast showToast];
    }
    
    return toast;
}

+ (ToastView *)presentToastWithin:(UIView *)superview text:(NSString *)text
{
    ToastView *toast = [[ToastView alloc] initWithText:text toastType:APToastIconLoading];
    [superview addSubview:toast];
    [toast setToastViewPosition:toast];
    
    [toast pushToStack];
    return toast;
}

+ (ToastView *)presentToastWithText:(NSString *)text
{
    ToastView *toast = [[ToastView alloc] initWithText:text toastType:APToastIconLoading];
    CGRect frame = [[UIScreen mainScreen] bounds];
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 44 + 20, frame.size.width, frame.size.height - 44 - 20)];
    [[UIApplication sharedApplication].keyWindow addSubview:backgroundView];
    [backgroundView addSubview:toast];
    toast.backgoundView = backgroundView;
    [toast setToastViewPosition:toast];
    
    [toast pushToStack];
    return toast;
}

+ (ToastView *)presentModelToastWithin:(UIView *)superview text:(NSString *)text
{
    ToastView *toast = [[ToastView alloc] initWithText:text toastType:APToastIconNone];
    UIView *backgroundView = [[UIView alloc] initWithFrame:superview.bounds];
    [superview addSubview:backgroundView];
    [backgroundView addSubview:toast];
    toast.backgoundView = backgroundView;
    [toast setToastViewPosition:toast];
    
    [toast pushToStack];
    return toast;
}

- (id)initWithText:(NSString *)text toastType:(APToastIcon)icon
{
    self = [super init];
    if (self) {
        _iconType = icon;
        _xOffset = 0;
        _yOffset = 0;
        
        self.backgroundColor = [UIColor clearColor];
        
        // 添加提示类型图标
        [self addToastIconView : (nil != text && 0 != text.length)];
        
        // 添加背景图片
        UIImage *bgImage = _iconView ? APCommonUILoadImage(@"toast_icon_bg") : APCommonUILoadImage(@"toast_bg");
        
        
        UIImageView *background = [[UIImageView alloc] initWithFrame:self.bounds];
        [background setImage:[bgImage stretchableImageWithLeftCapWidth:6 topCapHeight:6]];
        [self insertSubview:background atIndex:0];
        
        CGFloat toastViewWidth = _iconView ? (APCommonUIIsIphone6Plus ? 90 : 90) : 230;
        CGFloat textWidth = _iconView ? (APCommonUIIsIphone6Plus ? 90 : 90) : (toastViewWidth - 26);
        UIFont *textFont = [UIFont systemFontOfSize:13];
        
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(textWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : textFont} context:nil].size;
        // 视觉要求纯文本时，左右间距为15，微调后设置为13
        CGFloat xOffset = _iconView ? 0 : 13;
        CGFloat yOffset = _iconView ? CGRectGetMaxY(_iconView.frame) + (APCommonUIIsIphone6Plus ? 10 : 10) : 15;
        
        CGFloat toastViewHeight = 0;
        if(nil != text && 0 != text.length){
            _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, textWidth, textSize.height)];
            _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _textLabel.numberOfLines = 0;
            _textLabel.font = textFont;
            _textLabel.textAlignment = NSTextAlignmentCenter;
            _textLabel.backgroundColor = [UIColor clearColor];
            _textLabel.textColor = [UIColor whiteColor];
            
            _textLabel.text = text;
            [self addSubview:_textLabel];
            
            toastViewHeight = CGRectGetMaxY(_textLabel.frame) + ((_iconView && APCommonUIIsIphone6Plus) ? 15 : 15);
        }else{
            toastViewHeight = yOffset + ((_iconView && APCommonUIIsIphone6Plus) ? 15 : 15);
        }
        
        self.frame = CGRectMake(0, 0, toastViewWidth, toastViewHeight);
        background.frame = self.bounds;
        
        _second = 2.0;
        
        //自动化测试 获取toast显示字符串
        Class autoTestClass = NSClassFromString(@"ExternalInterface");
        if(autoTestClass){
            self.toastDelegate = [[autoTestClass alloc]init];
            [self.toastDelegate queryToastText:text];
        }
        
        //添加键盘消息监控
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardDidHideNotification
                                                   object:nil];
    }
    return self;
}

- (void)addToastIconView :(BOOL)hasText
{
    if (_iconType == APToastIconSuccess) {
        _iconView = [[UIImageView alloc] initWithImage:APCommonUILoadImage(@"toast_success")];
        [self addSubview:_iconView];
    } else if (_iconType == APToastIconFailure) {
        _iconView = [[UIImageView alloc] initWithImage:APCommonUILoadImage(@"toast_failure")];
        [self addSubview:_iconView];
    } else if (_iconType == APToastIconNetFailure) {
        _iconView = [[UIImageView alloc] initWithImage:APCommonUILoadImage(@"toast_net_failure")];
        [self addSubview:_iconView];
    } else if (_iconType == APToastIconLoading) {
        _iconView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self addSubview:_iconView];
        [(UIActivityIndicatorView *)_iconView startAnimating];
    }
    
    if (_iconView) {
        CGRect frame = _iconView.frame;
        frame.origin.x = ((APCommonUIIsIphone6Plus ? 90 : 90) - frame.size.width) / 2;
        if(!hasText)
            frame.origin.y = APCommonUIIsIphone6Plus ? 25.0 : 25.0;
        else
            frame.origin.y = APCommonUIIsIphone6Plus ? 15.0 : 15.0;
        _iconView.frame = frame;
    }
}

- (void)showToast
{
    self.hidden = NO;
    // modify by 妙玄 修改X和Y坐标的偏移量
    self.center = CGPointMake(CGRectGetMidX(self.superview.bounds) + _xOffset, CGRectGetMidY(self.superview.bounds) + _yOffset);
    if ([self isUIKeyboardVisable]) {
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetHeight(self.superview.bounds) - CGRectGetHeight(self.keyboardView.frame) - CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }
    
    if (self.toastDelegate) {
        [self.toastDelegate toastAppear];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_second
                                                  target:self
                                                selector:@selector(dismissToast)
                                                userInfo:nil
                                                 repeats:NO];
}

- (void)showDelayedToast
{
    [self pushToStack];
    [self showToast];
}

static BOOL ALPViewContains(UIView *parent, UIView *child)
{
    while (child && child != parent) {
        child = child.superview;
    }
    return child == parent;
}

- (BOOL)relatedToToast:(ToastView *)toast
{
    UIView *view1 = self.backgoundView ? self.backgoundView.superview : self.superview;
    UIView *view2 = toast.backgoundView ? toast.backgoundView.superview : toast.superview;
    return ALPViewContains(view1, view2) || ALPViewContains(view2, view1);
}

- (void)pushToStack
{
    [self.window.toastStack addObject:self];
    [self suppressRelatedToasts:YES];
    [self updateAllToastDisplay];
}

- (void)popFromStack
{
    [self suppressRelatedToasts:NO];
    [self.window.toastStack removeObject:self];
}

// 增减较早toast的supressCount
- (void)suppressRelatedToasts:(BOOL)flag
{
    for (ToastView *toast in self.window.toastStack) {
        if (toast == self) {
            break;
        }
        if ([self relatedToToast:toast]) {
            toast.suppressCount += flag ? 1 : -1;
        }
    }
}

// 更新所有Toast的显示情况
- (void)updateAllToastDisplay
{
    for (ToastView *toast in self.window.toastStack) {
        if (toast == self) {
            break;
        }
        toast.hidden = toast.suppressCount > 0;
    }
}


- (void)dismissToast
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self popFromStack];
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self updateAllToastDisplay];
                         
                         //toast消失时调用的委托方法
                         if (self.toastDelegate) {
                             [self.toastDelegate toastDissAppear];
                         }
                         
                         if (self.backgoundView) {
                             [self.backgoundView removeFromSuperview];
                             self.backgoundView = nil;
                         }
                         else {
                             [self removeFromSuperview];
                         }
                         
                         if (self.completion) {
                             self.completion();
                         }
                     }];
    
}

// modify by 妙玄 设置X坐标的偏移量
- (void)setXOffset:(CGFloat)xOffset
{
    _xOffset = xOffset;
    self.center = CGPointMake(CGRectGetMidX(self.superview.bounds) + _xOffset, self.center.y);
}

// modify by 妙玄 设置Y坐标的偏移量
- (void)setYOffset:(CGFloat)yOffset
{
    _yOffset = yOffset;
    self.center = CGPointMake(self.center.x, CGRectGetMidY(self.superview.bounds) + _yOffset);
}


- (BOOL)isUIKeyboardVisable
{
    BOOL keyboardVisible = NO;
    // Locate non-UIWindow.
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]) {
        if (![[testWindow class] isEqual:[UIWindow class]]) {
            keyboardWindow = testWindow;
            break;
        }
    }
    // Locate UIKeyboard.
    for (UIView *possibleKeyboard in [keyboardWindow subviews]) {
        // iOS 4 sticks the UIKeyboard inside a UIPeripheralHostView.
        if ([[possibleKeyboard description] hasPrefix:@"<UIPeripheralHostView"]) {
            keyboardVisible = YES;
        }
        if ([[possibleKeyboard description] hasPrefix:@"<UIKeyboard"]) {
            keyboardVisible = YES;
            break;
        }
        if (keyboardVisible) {
            self.keyboardView = possibleKeyboard;
        }
    }
    return keyboardVisible;
}

- (void)setToastViewPosition:(ToastView *)toast
{
    toast.center = CGPointMake(CGRectGetMidX(toast.superview.bounds), CGRectGetMidY(toast.superview.bounds));
    if ([self isUIKeyboardVisable]) {
        CGRect toastFrame = toast.frame;
        toastFrame.origin.y = CGRectGetHeight(toast.superview.bounds) - CGRectGetHeight(self.keyboardView.frame) - CGRectGetHeight(toast.frame);
        toast.frame = toastFrame;
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSValue *value = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = [value CGRectValue].size.height;
    CGFloat toastMaxY = CGRectGetMaxY(self.frame);
    CGFloat keyboardMinY = CGRectGetHeight(self.superview.bounds) - keyboardHeight;
    if (toastMaxY > keyboardMinY) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.frame;
            rect.origin.y = keyboardMinY - rect.size.height;
            self.frame = rect;
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        self.center = CGPointMake(CGRectGetMidX(self.superview.bounds), CGRectGetMidY(self.superview.bounds));
    }];
}

@end


@implementation UIWindow (ToastView)

static const char kToastStack;

- (NSMutableArray *)toastStack
{
    NSMutableArray *ret = objc_getAssociatedObject(self, &kToastStack);
    if (!ret) {
        ret = [NSMutableArray array];
        objc_setAssociatedObject(self, &kToastStack, ret, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return ret;
}

@end
