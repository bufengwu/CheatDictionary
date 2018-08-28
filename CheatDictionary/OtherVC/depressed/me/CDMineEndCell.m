//
//  CDMineEndCell.m
//  CheatDictionary
//
//  Created by 哔哩哔哩 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDMineEndCell.h"
#import "CDMineEndModel.h"

@interface CDMineEndCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CDMineEndCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = mainBgColor;
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDMineEndModel *)object {
    self.iconImageView.image = [UIImage imageNamed:object.icon];
    self.titleLabel.text = object.title;
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH, 50);
}

#pragma mark -

- (void)configSubviews {
    
    UIView *bgView = [UIView new];
    [bgView addSubview:self.iconImageView];
    [bgView addSubview:self.titleLabel];
    [self.contentView addSubview:bgView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.left.top.bottom.equalTo(bgView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.right.equalTo(bgView).offset(-5);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = FontBlack;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
