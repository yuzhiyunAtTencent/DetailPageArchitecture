//
//  YUNNewsCell.h
//  PatentDemo
//
//  Created by zhiyunyu on 2018/12/12.
//  Copyright © 2018 zhiyunyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YUNNewsItem;

NS_ASSUME_NONNULL_BEGIN

@interface YUNNewsCell : UITableViewCell

+ (CGFloat)height;
- (void)layoutWithData:(YUNNewsItem *)item;

@end

NS_ASSUME_NONNULL_END
