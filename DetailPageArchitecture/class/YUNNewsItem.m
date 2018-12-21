//
//  YUNNewsItem.m
//  PatentDemo
//
//  Created by zhiyunyu on 2018/12/12.
//  Copyright © 2018 zhiyunyu. All rights reserved.
//

#import "YUNNewsItem.h"

@implementation YUNNewsItem

- (instancetype)initWithTitle:(NSString *)title imgUrl:(NSString *)imgUrl {
    self = [super init];
    if (self) {
        self.title = [title copy];
        self.imgUrl = [imgUrl copy];
    }
    return self;
}

@end
