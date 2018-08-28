//
//  CDPlayRuleCell.m
//  ZYLab
//
//  Created by 哔哩哔哩 on 2018/7/3.
//  Copyright © 2018年 哔哩哔哩. All rights reserved.
//

#import "CDPlayRuleCell.h"
#import "CDPlayRuleModel.h"

@interface CDPlayRuleCell()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CDPlayRuleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDPlayRuleModel *)object {
    self.coverImageView.image = [UIImage imageNamed:object.icon];
    self.titleLabel.text = object.title;
    self.contentLabel.text = object.content;
}

+ (CGSize)getSizeWithObject:(id)object {
    CGFloat width = floor(SCREEN_WIDTH/2);
    return CGSizeMake(width, 50);
}

#pragma mark -

- (void)configSubviews {
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@(30));
        make.left.equalTo(@(32));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coverImageView);
        make.left.equalTo(self.coverImageView.mas_right).offset(10);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.coverImageView);
        make.left.equalTo(self.coverImageView.mas_right).offset(10);
    }];
}

- (UIImageView *)coverImageView {
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] init];
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = FontBlack;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

@end
