//
//  CDUserCenterCell.m
//  CheatDictionary
//
//  Created by 哔哩哔哩 on 2018/7/5.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDUserCenterItemCell.h"
#import "CDUserCenterItemModel.h"

@interface CDUserCenterItemCell()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CDUserCenterItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDUserCenterItemModel *)object {

}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH, 50);
}

#pragma mark -

- (void)configSubviews {
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 10, 10, 10));
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH - 40, 30);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 15)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = rect;
        maskLayer.path = maskPath.CGPath;
        self.bgView.layer.mask = maskLayer;
//        self.bgView.backgroundColor = mainBgColor;
    }
    return _bgView;
}


@end
