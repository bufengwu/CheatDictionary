//
//  CDSectionHeaderShowMoreView.m
//  ZYLab
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDSectionHeaderShowMoreView.h"
#import "CDShowMoreHeaderModel.h"

@interface CDSectionHeaderShowMoreView()

@property (nonatomic, strong) CDShowMoreHeaderModel *model;

@end

@implementation CDSectionHeaderShowMoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDShowMoreHeaderModel *)object {
    self.model = object;
    
    self.titleLabel.text = object.title;
    if (object.more) {
        self.moreLabel.text = [object.more stringByAppendingString:@" >"];
    }
}

- (void)installHeaderViewWithTitle:(NSString *)title more:(NSString *)more {
    self.titleLabel.text = title;
    if (more) {        
        self.moreLabel.text = [more stringByAppendingString:@" >"];
    }
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH, 30);
}

#pragma mark -

- (void)labelTouchUpInside:(UITapGestureRecognizer *)recognizer {
    if (!self.model.uri) {
        return;
    }
    [[CDRouter shared] pushUrl:self.model.uri animated:YES];
}

#pragma mark -

- (void)configSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.moreLabel];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];

    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = SectionHeaderTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (UILabel *)moreLabel {
    if (!_moreLabel) {
        _moreLabel = [[UILabel alloc] init];        
        _moreLabel.textColor = FontBlack;
        _moreLabel.font = [UIFont systemFontOfSize:11];
        
        _moreLabel.userInteractionEnabled=YES;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
        
        [_moreLabel addGestureRecognizer:labelTapGestureRecognizer];
    }
    return _moreLabel;
}

@end
