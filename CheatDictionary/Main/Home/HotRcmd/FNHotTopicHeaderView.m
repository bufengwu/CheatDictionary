//
//  FNHotTopicHeaderView.m
//  CheatDictionary
//
//  Created by zhengyi on 2019/3/2.
//  Copyright © 2019 朱正毅. All rights reserved.
//

#import "FNHotTopicHeaderView.h"

@interface FNHotTopicHeaderViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIImageView *maskView;
@end

@implementation FNHotTopicHeaderViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _createSubviews];
        [self _makeConstraints];
    }
    return self;
}

- (void)_createSubviews {
    _backgroundView = [UIImageView new];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    [self addSubview:_backgroundView];
    
    _maskView = [UIImageView new];
    _maskView.image = [UIImage imageNamed:@"common_shadow_top"];
    [_backgroundView addSubview:_maskView];
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.numberOfLines = 2;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    self.layer.borderWidth = 1;
    self.layer.borderColor = CollectCellBorderColor.CGColor;
}

- (void)_makeConstraints {
    {
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(8);
            make.top.equalTo(self).offset(6);
            make.right.equalTo(self).offset(-8);
        }];
    }
    
    {
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            
        }];
    }
    {
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
}

- (void)setItem:(CDChannelCoverModel *)item {
    self.titleLabel.text = item.title;
    [self.backgroundView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
}

@end

CGFloat const kFNHotTopicHeaderViewH = 58.f;
CGFloat const kFNHotTopicHeaderViewW = 102.0;

@interface FNHotTopicHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *viewAllButton;
@property (nonatomic, strong) UIButton *backgroundButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) FNHotTopicHeaderModel *viewModel;

@end

@implementation FNHotTopicHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _createSubviews];
    }
    return self;
}

#pragma mark - initiation
- (void)_createSubviews {
    self.clipsToBounds = YES;
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _titleLabel.textColor = FontBlack;
    _titleLabel.text = @"热门话题";
    [self addSubview:_titleLabel];
    
    _viewAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _viewAllButton.adjustsImageWhenHighlighted = NO;
    _viewAllButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_viewAllButton setTitleColor:FontBlack forState:UIControlStateNormal];
    UIImage *image = [[UIImage imageNamed:(@"home_general_pulldown_small")] cd_imageWithTintColor:FontBlack];
    [_viewAllButton setImage:image forState:UIControlStateNormal];
    [_viewAllButton setTitle:@"发现更多话题" forState:UIControlStateNormal];
    _viewAllButton.imageView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self addSubview:_viewAllButton];
    
    _backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    @weakify(self);
    [[_backgroundButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [[CDRouter shared] pushUrl:self.viewModel.uri animated:YES];
    }];
    [self addSubview:_backgroundButton];
    
    _scrollView = [UIScrollView new];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = MainLightBrownColor;
    _scrollView.alwaysBounceHorizontal = YES;
    [self addSubview:_scrollView];
    
    self.backgroundColor = MainLightBrownColor;
    
}

- (void)_layout {
    CGFloat leftPadding = 12;
    CGFloat topBottomPadding = 5;
    
    self.titleLabel.tz_left = leftPadding;
    self.titleLabel.tz_top = topBottomPadding;
    [self.titleLabel sizeToFit];
    
    [self.viewAllButton.titleLabel sizeToFit];
    self.viewAllButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.viewAllButton.titleLabel.tz_width + 4, 0, -(self.viewAllButton.titleLabel.tz_width + 4));
    self.viewAllButton.titleEdgeInsets = UIEdgeInsetsMake(0, -self.viewAllButton.currentImage.size.width, 0, self.viewAllButton.currentImage.size.width);
    [self.viewAllButton sizeToFit];
    self.viewAllButton.tz_left = self.tz_width - 18 - self.viewAllButton.tz_width;
    self.viewAllButton.tz_centerY = self.titleLabel.tz_centerY;
    
    self.backgroundButton.tz_width = 100;
    self.backgroundButton.tz_height = 43;
    self.backgroundButton.tz_right = self.tz_width;
    self.backgroundButton.tz_top = 0;
    
    self.scrollView.frame = CGRectMake(0, 27, self.tz_width,kFNHotTopicHeaderViewH);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self _layout];
}

- (void)bindViewModel:(FNHotTopicHeaderModel *)viewModel {
    self.viewModel = viewModel;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat padding = 10;
    CGFloat leftPadding = 12;
    CGFloat width = kFNHotTopicHeaderViewW;
    
    NSArray *hotTopicModels = viewModel.items;
    [hotTopicModels enumerateObjectsUsingBlock:^(CDChannelCoverModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = leftPadding + (width + padding) * idx;
        CGRect rect = CGRectMake(x, 0, width, kFNHotTopicHeaderViewH);
        FNHotTopicHeaderViewCell *cell = [[FNHotTopicHeaderViewCell alloc] initWithFrame:rect];
        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
        [tap.rac_gestureSignal subscribeNext:^(id x) {
            [[CDRouter shared] pushUrl:obj.uri animated:YES];
        }];
        [cell addGestureRecognizer:tap];
        [cell setItem:obj];
        [self.scrollView addSubview:cell];
    }];
    CGFloat contentW = 2 * leftPadding + (width * hotTopicModels.count) + (hotTopicModels.count - 1) * padding;
    [self.scrollView setContentSize:CGSizeMake(contentW, 0)];
}

@end
