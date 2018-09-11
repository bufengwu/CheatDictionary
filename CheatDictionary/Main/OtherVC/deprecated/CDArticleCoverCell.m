//
//  CDArticleCell.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDArticleCoverCell.h"
#import "CDArticleCoverModel.h"

@implementation CDArticleCoverCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDArticleCoverModel *)object {
    self.coverImageView.image = [UIImage imageNamed:@"default_room_icon"];
    self.titleLabel.text = object.title;
    self.contentLabel.text = [NSString stringWithFormat:@"%lu人已答过", object.number];
}

+ (CGSize)getSizeWithObject:(id)object {
    CGFloat width = floor((SCREEN_WIDTH-64) / 3.0);
    return CGSizeMake(width, width/0.8 + 30);
}

#pragma mark -

- (void)configSubviews {
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.width.equalTo(self.coverImageView.mas_height).multipliedBy(0.8);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coverImageView.mas_bottom).offset(5);
        make.left.equalTo(self.coverImageView);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView).offset(5);
        make.bottom.equalTo(self.coverImageView).offset(-3);
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
