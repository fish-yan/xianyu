//
//  C_FullJobTypeSelectHeaderView.m
//  XianYu
//
//  Created by lmh on 2019/7/21.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_FullJobTypeSelectHeaderView.h"
#import "JSFactory.h"
#import "C_SelectDeleteView.h"

@implementation C_FullJobTypeSelectHeaderView

- (RACSubject *)clearSubject
{
    if (!_clearSubject) {
        self.clearSubject = [RACSubject subject];
    }
    return _clearSubject;
}

- (RACSubject *)removeSubject
{
    if (!_removeSubject) {
        self.removeSubject = [RACSubject subject];
    }
    return _removeSubject;
}





- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = Color_White;
    }
    return self;
}

- (void)createUI
{
    self.nameLabel = [JSFactory creatLabelWithTitle:@"已选择" textColor:Color_Black_464646 textFont:font750(30) textAlignment:(NSTextAlignmentLeft)];
    self.modifyButton = [JSFactory creatButtonWithTitle:@"清空" textFont:font750(26) titleColor:Color_Black_A5A5A5 backGroundColor:Color_White];
    [[self.modifyButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.clearSubject sendNext:nil];
    }];
    [self.modifyButton setImage:GetImage(@"icon_c_fulljob_type_modify") forState:(UIControlStateNormal)];
    [self addSubview:self.nameLabel];
    [self addSubview:self.modifyButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(@(Anno750(24)));
        make.height.equalTo(@(Anno750(42)));
    }];
    [self.modifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(self.nameLabel);
        make.size.mas_equalTo(CGSizeMake(Anno750(160), Anno750(60)));
    }];
}

- (CGFloat)createSelectButtonArray:(NSArray *)array
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[C_SelectDeleteView class]] && view.tag >= 5000) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat view_x = 0;
    CGFloat view_y = 0;
    CGFloat view_w = (KScreenWidth - Anno750(132)) / 3.0;
    CGFloat view_h = Anno750(60);
    int row = 0;
    C_SelectDeleteView *lastView = nil;
    for (int i = 0; i < array.count; i++) {
        JobTypeModel *model = array[i];
        view_y = Anno750(102) + row * Anno750(80);
        if (i % 3 == 0) {
            view_x = Anno750(24);
        }
        else if (i % 3 == 1)
        {
            view_x = CGRectGetMaxX(lastView.frame) + Anno750(42);
        }
        else if (i % 3 == 2)
        {
            view_x = CGRectGetMaxX(lastView.frame) +  Anno750(42);
            row++;
        }
        C_SelectDeleteView *view = [[C_SelectDeleteView alloc]initWithFrame:(CGRectMake(view_x, view_y, view_w, view_h))];
        view.tag = 5000 + i;
        view.nameLabel.text = model.name;
        [[view.deleteButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.removeSubject sendNext:model];
        }];
        [self addSubview:view];
        lastView = view;
    }
    if (array.count == 0) {
        return 0;
    }
    return CGRectGetMaxY(lastView.frame) + Anno750(50);
    
}




@end
