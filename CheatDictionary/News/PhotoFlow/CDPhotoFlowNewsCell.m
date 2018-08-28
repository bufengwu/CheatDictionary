//
//  CDPhotoFlowNewsCell.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/21.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDPhotoFlowNewsCell.h"
#import "CDPhotoFlowNewsModel.h"

@implementation CDPhotoFlowNewsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDPhotoFlowNewsModel *)object {
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:object.cover] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    self.titleLabel.text = object.title;
    self.contentLabel.text = object.author;
    
    [self.coverImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat width = (SCREEN_WIDTH - 20 - 5)/2.f;
        CGFloat h = object.cover_h * (width / object.cover_w);
        make.height.equalTo(@(h));
    }];
}

+ (CGSize)getSizeWithObject:(CDPhotoFlowNewsModel *)object {
    CGFloat width = (SCREEN_WIDTH - 20 - 5)/2.f;
    CGFloat h = object.cover_h * (width / object.cover_w) + 45;
    return CGSizeMake(width, h);
}

#pragma mark -

- (void)configSubviews {
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@10);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coverImageView.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(5);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(5);
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
        _contentLabel.textColor = FontBlack;
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

@end
