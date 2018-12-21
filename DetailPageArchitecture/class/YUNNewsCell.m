//
//  YUNNewsCell.m
//  PatentDemo
//
//  Created by zhiyunyu on 2018/12/12.
//  Copyright © 2018 zhiyunyu. All rights reserved.
//

#import "YUNNewsCell.h"
#import "YUNNewsItem.h"

@interface YUNNewsCell ()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) UIImageView *coverImageView;

@end

@implementation YUNNewsCell

#pragma mark - Override

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.coverImageView];
    }
    return self;
}

#pragma mark - Public Methods

+ (CGFloat)height {
    return 150;
}

- (void)layoutWithData:(YUNNewsItem *)item {
    self.titleLabel.text = item.title;
    [self.titleLabel sizeToFit];
    
    self.dateLabel.text = @"2018-09-23";
    [self.dateLabel sizeToFit];
    
    self.coverImageView.image = [UIImage imageNamed:item.imgUrl];
    [self p_layoutSubviews];
}

#pragma mark - Private Methods

- (void)p_layoutSubviews {
//    self.coverImageView.frame = CGRectMake(200, 5, self.bounds.size.width - 200, 140);
    self.titleLabel.frame = CGRectIntegral(self.titleLabel.frame);
}

#pragma mark - Accessors

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 130, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.numberOfLines = 4;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        CGFloat height = 20;
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, [self.class height] - height - 5, 130, height)];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.numberOfLines = 1;
        _dateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _dateLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _dateLabel;
}


- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        CGFloat leftSpace = 160;
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftSpace, 5, [UIScreen mainScreen].bounds.size.width - leftSpace - 10, 140)];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.clipsToBounds = YES;
    }
    return _coverImageView;
}


@end
