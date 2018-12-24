//
//  UIView+QNUtil.m
//  DetailPageArchitecture
//
//  Created by zhiyunyu on 2018/12/24.
//  Copyright © 2018 zhiyunyu. All rights reserved.
//

#import "UIView+QNUtil.h"

@implementation UIView (QNUtil)

- (CGFloat)qn_top {
    return self.frame.origin.y;
}

- (void)setQn_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

@end
