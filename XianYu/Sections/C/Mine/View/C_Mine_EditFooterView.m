//
//  C_Mine_EditFooterView.m
//  XianYu
//
//  Created by Yan on 2019/8/1.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "C_Mine_EditFooterView.h"
#import "XYPickPhotoUtils.h"

@interface C_Mine_EditFooterView ()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray<UIView *> *views;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray<UIImageView *> *imgs;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray<UIButton *> *btns;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray<UIButton *> *deleteBtns;
@property (strong, nonatomic) UIView *oneView;
@end

@implementation C_Mine_EditFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadOneView];
    }
    return self;
}

- (void)configImgs {
    
        NSString *urlstr1 = [self.img1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.imgs[0] sd_setImageWithURL:[NSURL URLWithString:urlstr1]];
    if (self.img1.length != 0) {
        self.views[1].hidden = NO;
    }
    
        NSString *urlstr2 = [self.img2 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.imgs[1] sd_setImageWithURL:[NSURL URLWithString:urlstr2]];
    if (self.img2.length != 0) {
        self.views[2].hidden = NO;
    }
    
        NSString *urlstr3 = [self.img3 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.imgs[2] sd_setImageWithURL:[NSURL URLWithString:urlstr3]];
    if (self.img3.length != 0) {
        if (self.imgCount == 4) {
            self.views[3].hidden = NO;
        }
    }
    
        NSString *urlstr4 = [self.img4 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.imgs[3] sd_setImageWithURL:[NSURL URLWithString:urlstr4]];
    self.deleteBtns[0].hidden = self.img1.length == 0;
    self.deleteBtns[1].hidden = self.img2.length == 0;
    self.deleteBtns[2].hidden = self.img3.length == 0;
    self.deleteBtns[3].hidden = self.img4.length == 0;

}

- (void)loadOneView {
    self.oneView = [[UINib nibWithNibName:@"C_Mine_EditFooterView" bundle:nil] instantiateWithOwner:self options:nil].firstObject;
    self.oneView.frame = self.bounds;
    [self addSubview:self.oneView];
    self.imgCount = 3;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.oneView.frame = self.bounds;
}

- (IBAction)addImageAction:(UIButton *)sender {
    [XYPickPhotoUtils pickPhoto:[UIViewController visibleViewController] complete:^(UIImage * _Nonnull img) {
        
        [[OSSManager share] uploadImage:img withSize:CGSizeMake(110, img.size.height * 110 / img.size.width) withBlock:^(id  _Nonnull result) {
            NSString *imageStr = result;
            !self.complete ?: self.complete(imageStr, sender.tag - 100);
            if (sender.tag == 100) {
                self.img1 = imageStr;
            } else if (sender.tag == 101) {
                self.img2 = imageStr;
            } else if (sender.tag == 102) {
                self.img3 = imageStr;
            } else if (sender.tag == 103) {
                self.img4 = imageStr;
            }
            [self configImgs];
        }];
    }];
}

- (IBAction)deleteAction:(UIButton *)sender {
    if (sender.tag == 100) {
        self.img1 = @"";
        self.imgs[0].image = nil;
    } else if (sender.tag == 101) {
        self.img2 = @"";
        self.imgs[1].image = nil;
    } else if (sender.tag == 102) {
        self.img3 = @"";
        self.imgs[2].image = nil;
    } else if (sender.tag == 103) {
        self.img4 = @"";
        self.imgs[3].image = nil;
    }
    !self.complete ?: self.complete(@"", sender.tag - 100);
    [self configImgs];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
