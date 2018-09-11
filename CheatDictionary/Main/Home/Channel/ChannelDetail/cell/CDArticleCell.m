//
//  CDArticleCell.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDArticleCell.h"
#import "CDArticleModel.h"

@implementation CDArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
    }    
    return self;
}

- (void)installWithObject:(CDArticleModel *)object {
    self.titleLabel.text = object.title;
    self.contentLabel.text = object.desc;
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:object.cover] placeholderImage:[UIImage imageNamed:@"article_image_default"]];
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
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.height.mas_equalTo(60);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.coverImageView.mas_left).offset(-10);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.right.equalTo(self.coverImageView.mas_left).offset(-10);
    }];
}

- (UIImageView *)coverImageView {
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = FontBlack;
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = FontBlack;
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}

@end
