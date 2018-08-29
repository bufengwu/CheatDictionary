//
//  CDTopActivityCell.m
//  ZYLab
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDTopActivityCell.h"
#import "CDTopActivityModel.h"

@implementation CDTopActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
    }
    return self;
    
}

-(void)installWithObject:(CDTopActivityModel *)object {
    //    self.coverImageView.image = coverImage;
    self.titleLabel.text = object.title;
    self.contentLabel.text = object.content;
    self.challengeNumberLabel.text = [NSString stringWithFormat:@"%lu人已挑战", (unsigned long)object.number];
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH-32, 70);
}

#pragma mark -

- (void)configSubviews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.challengeNumberLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.challengeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

- (CDCustomTagLabel *)challengeNumberLabel {
    if (_challengeNumberLabel == nil) {
        _challengeNumberLabel = [[CDCustomTagLabel alloc] init];
        _challengeNumberLabel.textColor = [UIColor redColor];
        _challengeNumberLabel.font = [UIFont systemFontOfSize:11];
        _challengeNumberLabel.layer.borderWidth = 1;
        _challengeNumberLabel.layer.borderColor = [UIColor redColor].CGColor;
        _challengeNumberLabel.edgeInsets = UIEdgeInsetsMake(2, 3, 2, 3);
    }
    return _challengeNumberLabel;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = FontBlack;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 1;
    }
    return _contentLabel;
}

@end
