//
//  CALayer+Extension.m
//  XianYu
//
//  Created by Yan on 2019/7/15.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "CALayer+Extension.h"

@implementation CALayer (Extension)

- (UIColor *)bcolor {
    return [UIColor colorWithCGColor:self.borderColor];
}

- (void)setBcolor:(UIColor *)bcolor {
    self.borderColor = bcolor.CGColor;
}

- (UIColor *)scolor {
    return [UIColor colorWithCGColor:self.shadowColor];
}

- (void)setScolor:(UIColor *)scolor {
    self.shadowColor = scolor.CGColor;
}

@end
