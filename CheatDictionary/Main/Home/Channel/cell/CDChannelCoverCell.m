//
//  CDChannelCoverCell.m
//  ZYLab
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDChannelCoverCell.h"
#import "CDChannelCoverModel.h"

#define ImageWidth 40

@interface CDChannelCoverCell()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation CDChannelCoverCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDChannelCoverModel *)object {
    self.coverImageView.image = [UIImage imageNamed:object.icon];
    self.titleLabel.text = object.title;
    self.subtitleLabel.text = object.subtitle;
    self.badgeLabel.text = [NSString stringWithFormat:@"%d", object.badge];
}

+ (CGSize)getSizeWithObject:(id)object {
    CGFloat width = floor((SCREEN_WIDTH - 60)/2.0);
    return CGSizeMake(width, width/2.67);
}

#pragma mark -

- (void)configSubviews {
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.borderColor = CollectCellBorderColor.CGColor;
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subtitleLabel];
    [self.contentView addSubview:self.badgeLabel];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@(ImageWidth));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coverImageView).offset(4);
        make.left.equalTo(self.coverImageView.mas_right).offset(4);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.coverImageView).offset(-4);
        make.left.equalTo(self.coverImageView.mas_right).offset(4);
    }];
    [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel);
        make.left.equalTo(self.titleLabel.mas_right).offset(4);
    }];
}

- (UIImageView *)coverImageView {
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] init];
        CALayer *layer = [_coverImageView layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:ImageWidth/2.f];
        [layer setBorderWidth:1];
        [layer setBorderColor:RGB(96, 67, 17).CGColor];
        
        CALayer *boderLayer = [CALayer layer];
        boderLayer.position = CGPointMake(ImageWidth/2, ImageWidth/2);
        boderLayer.bounds = CGRectMake(0, 0, ImageWidth - 2, ImageWidth - 2);
        boderLayer.cornerRadius = ImageWidth/2.f - 1;
        boderLayer.masksToBounds = YES;
        boderLayer.borderWidth = 2;
        boderLayer.borderColor = RGB(176, 150, 107).CGColor;
        [layer addSublayer:boderLayer];
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = RGB(63, 45, 33);
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (_subtitleLabel == nil) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.textColor = RGB(132, 115, 94);
        _subtitleLabel.font = [UIFont systemFontOfSize:10];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subtitleLabel;
}

- (UILabel *)badgeLabel {
    if (_badgeLabel == nil) {
        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.textColor = RGB(194, 65, 11);
        _badgeLabel.font = [UIFont systemFontOfSize:8];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLabel;
}

@end
