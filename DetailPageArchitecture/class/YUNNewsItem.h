//
//  YUNNewsItem.h
//  PatentDemo
//
//  Created by zhiyunyu on 2018/12/12.
//  Copyright © 2018 zhiyunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YUNNewsItem : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *imgUrl;

- (instancetype)initWithTitle:(NSString *)title imgUrl:(NSString *)imgUrl;

@end

NS_ASSUME_NONNULL_END
