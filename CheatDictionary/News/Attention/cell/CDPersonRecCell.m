//
//  CDPersonRecCell.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/12.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDPersonRecCell.h"
#import "CDPersonRecModel.h"

@interface CDPersonRecCell()

@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *descLabel1;
@property (strong, nonatomic) UILabel *descLabel2;

@end

@implementation CDPersonRecCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = RGB(207, 196, 172);
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDPersonRecModel *)object {
    self.avatarView.image = [UIImage imageNamed:object.icon];
    self.nameLabel.text = object.name;
    self.descLabel1.text = object.desc1;
    self.descLabel2.text = object.desc2;
}


+ (CGSize)getSizeWithObject:(id)object {
    CGFloat width = floor((SCREEN_WIDTH - 64) / 3.0) - 20;
    return CGSizeMake(width, 125);
}

#pragma mark -

- (void)configSubviews {
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 7;
    
    [self.contentView addSubview:self.avatarView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.descLabel1];
    [self.contentView addSubview:self.descLabel2];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(44));
        make.top.mas_equalTo(12);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_bottom).offset(5);
        make.centerX.equalTo(self.contentView);
    }];
    [self.descLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.centerX.equalTo(self.contentView);
    }];
    [self.descLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel1.mas_bottom).offset(5);
        make.centerX.equalTo(self.contentView);
    }];
}

#pragma mark -

- (UIImageView *)avatarView {
    if (_avatarView == nil) {
        _avatarView = [[UIImageView alloc] init];
    }
    return _avatarView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = FontBlack;
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)descLabel1 {
    if (_descLabel1 == nil) {
        _descLabel1 = [[UILabel alloc] init];
        _descLabel1.textColor = FontBlack;
        _descLabel1.font = [UIFont systemFontOfSize:11];
        _descLabel1.textAlignment = NSTextAlignmentCenter;
    }
    return _descLabel1;
}

- (UILabel *)descLabel2 {
    if (_descLabel2 == nil) {
        _descLabel2 = [[UILabel alloc] init];
        _descLabel2.textColor = FontBlack;
        _descLabel2.font = [UIFont systemFontOfSize:11];
        _descLabel2.textAlignment = NSTextAlignmentCenter;
    }
    return _descLabel2;
}

@end
