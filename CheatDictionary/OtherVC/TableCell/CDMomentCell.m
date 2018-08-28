//
//  CDAttentionCell.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDMomentCell.h"
#import "CDMomentModel.h"

@interface CDMomentCell()

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *actionLabel;

@property (nonatomic, strong) UILabel *momentTitleLabel;

@end

@implementation CDMomentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDMomentModel *)object {
    self.avatarImageView.image = [UIImage imageNamed:object.avatarImage];
    self.nameLabel.text = object.name;
    self.timeLabel.text = object.time;
    self.actionLabel.text = object.action;
    self.momentTitleLabel.text = object.momentTitle;
}

#pragma mark -

- (void)configSubviews {
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [self.contentView addSubview:self.actionLabel];
    
    UIView *momentBgView = [[UIView alloc] init];
    momentBgView.layer.borderWidth = 0.5;
    momentBgView.layer.borderColor = BorderLineGray.CGColor;
    [self.contentView addSubview:momentBgView];
    [momentBgView addSubview:self.momentTitleLabel];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView);
        make.left.equalTo(self.avatarImageView.mas_right).offset(5);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.avatarImageView);
        make.left.equalTo(self.avatarImageView.mas_right).offset(5);
    }];
    
    [self.actionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView);
        make.left.equalTo(self.nameLabel.mas_right).offset(5);
    }];
    
    [momentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.avatarImageView);
    }];
    
    [self.momentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(momentBgView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}

- (UIImageView *)avatarImageView {
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = FontBlack;
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = FontLightGray;
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

- (UILabel *)actionLabel {
    if (_actionLabel == nil) {
        _actionLabel = [[UILabel alloc] init];
        _actionLabel.textColor = FontLightGray;
        _actionLabel.font = [UIFont systemFontOfSize:13];
        _actionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _actionLabel;
}

- (UILabel *)momentTitleLabel {
    if (_momentTitleLabel == nil) {
        _momentTitleLabel = [[UILabel alloc] init];
        _momentTitleLabel.textColor = FontBlack;
        _momentTitleLabel.numberOfLines = 0;
        _momentTitleLabel.font = [UIFont systemFontOfSize:13];
        _momentTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _momentTitleLabel;
}

@end
