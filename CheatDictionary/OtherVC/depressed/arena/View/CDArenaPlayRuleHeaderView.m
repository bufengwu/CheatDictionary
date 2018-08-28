//
//  CDChannelCoverPlayRuleHeaderView.m
//  ZYLab
//
//  Created by 哔哩哔哩 on 2018/7/3.
//  Copyright © 2018年 哔哩哔哩. All rights reserved.
//

#import "CDChannelCoverPlayRuleHeaderView.h"
#import "CDChannelCoverPlayRuleHeaderModel.h"

@interface CDChannelCoverPlayRuleHeaderView()

@property (nonatomic, strong) UIImageView *titleIcon;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *vitalityLabel;
@property (nonatomic, strong) UIImageView *vitalityIcon;

@end

@implementation CDChannelCoverPlayRuleHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = mainBgColor;
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDChannelCoverPlayRuleHeaderModel *)object {
    
    self.titleLabel.text = object.title;
    self.vitalityLabel.text = object.vitality;
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH, 40);
}

#pragma mark -

- (void)configSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.titleIcon];
    [self addSubview:self.vitalityLabel];
    [self addSubview:self.vitalityIcon];
    
    self.titleIcon.image = [UIImage imageNamed:@"icon_what"];
    self.vitalityIcon.image = [UIImage imageNamed:@"icon_what"];
    
    [self.titleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.height.equalTo(@(15));
        make.width.equalTo(@(15));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleIcon.mas_right).offset(5);
        make.centerY.equalTo(self);
    }];
    
    [self.vitalityIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.height.equalTo(@(15));
        make.width.equalTo(@(15));
    }];
    
    [self.vitalityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.vitalityIcon.mas_left).offset(-5);
        make.centerY.equalTo(self);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = FontBlack;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UIImageView *)titleIcon {
    if (!_titleIcon) {
        _titleIcon = [[UIImageView alloc] init];
    }
    return _titleIcon;
}

- (UILabel *)vitalityLabel {
    if (!_vitalityLabel) {
        _vitalityLabel = [[UILabel alloc] init];
        _vitalityLabel.font = [UIFont systemFontOfSize:15];
        _vitalityLabel.textColor = [UIColor yellowColor];
    }
    return _vitalityLabel;
}

- (UIImageView *)vitalityIcon {
    if (!_vitalityIcon) {
        _vitalityIcon = [[UIImageView alloc] init];
    }
    return _vitalityIcon;
}

@end
