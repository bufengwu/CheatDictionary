//
//  CDDiscussionDetailUpperCell.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/16.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDDiscussionDetailUpperCell.h"
#import "CDDiscussionDetailUpperModel.h"
#import <TYAttributedLabel/TYAttributedLabel.h>

@interface CDDiscussionDetailUpperCell()

@property (nonatomic, strong) UIImageView *avatarImageView; //头像
@property (nonatomic, strong) UILabel *nameLabel;           //作者

@property (nonatomic, strong) UIButton *onlyWatchUpperButton;
@property (nonatomic, strong) UILabel *floorLabel;

@property (nonatomic, strong) UILabel *titleLabel;      //标题
@property (nonatomic, strong) TYAttributedLabel *contentLabel;    //内容

@property (nonatomic, strong) UILabel *timeLabel;   //时间
@property (nonatomic, strong) UIImageView *watchIcon;
@property (nonatomic, strong) UILabel *watchNumLabel;

@end

@implementation CDDiscussionDetailUpperCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
    }
    return self;
    
}

-(void)installWithObject:(CDDiscussionDetailUpperModel *)object {
    self.avatarImageView.image = [UIImage imageNamed:object.avatar];
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:object.avatar] placeholderImage:[UIImage imageNamed:@"icon_avatar_default"]];
    
    self.nameLabel.text = object.name;
    
    self.titleLabel.text = object.title;
    self.contentLabel.text = object.content;
    
    self.timeLabel.text = object.time;
    
    CGSize size = [self.contentLabel getSizeWithWidth:self.contentView.tz_width-20];
    
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height);
    }];
    
    self.watchNumLabel.text = [@(object.watch_num) stringValue];
    
}

#pragma mark -

- (void)configSubviews {
    
    self.avatarImageView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.onlyWatchUpperButton];
    [self.contentView addSubview:self.floorLabel];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    
    self.contentView.backgroundColor = RGB(205, 189, 160);
    self.contentLabel.backgroundColor = self.contentView.backgroundColor;
    
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.watchIcon];
    [self.contentView addSubview:self.watchNumLabel];
    //    self.backgroundColor = mainBgColor;
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.height.width.mas_equalTo(25);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(5);
        make.centerY.equalTo(self.avatarImageView);
    }];
    
    [self.floorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.avatarImageView);
    }];
    
    [self.onlyWatchUpperButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.floorLabel.mas_left).offset(-10);
        make.centerY.equalTo(self.avatarImageView);
        make.height.equalTo(@18);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.watchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).offset(10);
        make.centerY.equalTo(self.timeLabel);
    }];
    
    [self.watchNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.watchIcon.mas_right).offset(10);
        make.centerY.equalTo(self.timeLabel);
    }];
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [UIImageView new];
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = FontDarkGray;
        _nameLabel.font = [UIFont systemFontOfSize:11];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.numberOfLines = 1;
    }
    return _nameLabel;
}

- (UIButton *)onlyWatchUpperButton {
    if (!_onlyWatchUpperButton) {
        _onlyWatchUpperButton = [[UIButton alloc] init];
        [_onlyWatchUpperButton setTitle:@"只看楼主" forState:UIControlStateNormal];
        [_onlyWatchUpperButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_onlyWatchUpperButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [_onlyWatchUpperButton setBackgroundColor:[UIColor clearColor]];
        _onlyWatchUpperButton.contentEdgeInsets = UIEdgeInsetsMake(1, 5, 1, 5);
        _onlyWatchUpperButton.layer.borderColor = [UIColor redColor].CGColor;
        _onlyWatchUpperButton.layer.borderWidth = 1;
        _onlyWatchUpperButton.layer.cornerRadius = 2;
    }
    return _onlyWatchUpperButton;
}

- (UILabel *)floorLabel {
    if (!_floorLabel) {
        _floorLabel = [UILabel new];
        _floorLabel.text = @"1#";
        _floorLabel.font = [UIFont systemFontOfSize:10];
        _floorLabel.textColor = [UIColor grayColor];
    }
    return _floorLabel;
}


- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = FontBlack;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (TYAttributedLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[TYAttributedLabel alloc] init];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = FontDarkGray;
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.numberOfLines = 1;
    }
    return _timeLabel;
}

- (UIImageView *)watchIcon {
    if (!_watchIcon) {
        _watchIcon = [UIImageView new];
        _watchIcon.image = [[UIImage imageNamed:@"choice_eye_img_16x10_"] tintImageWithColor:[UIColor grayColor]];
    }
    return _watchIcon;
}

- (UILabel *)watchNumLabel {
    if (!_watchNumLabel) {
        _watchNumLabel = [UILabel new];
        _watchNumLabel.textColor = FontDarkGray;
        _watchNumLabel.font = [UIFont systemFontOfSize:11];
        _watchNumLabel.textAlignment = NSTextAlignmentLeft;
        _watchNumLabel.numberOfLines = 1;
    }
    return _watchNumLabel;
}

@end
