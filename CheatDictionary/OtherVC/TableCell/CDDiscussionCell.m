//
//  CDDiscussionCell.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/14.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDDiscussionCell.h"
#import "CDDiscussionModel.h"

@interface CDDiscussionCell()

@property (nonatomic, strong) UIImageView *authorIcon;
@property (nonatomic, strong) UIImageView *timeIcon;
@property (nonatomic, strong) UIImageView *commentIcon;

@property (nonatomic, strong) UILabel *nameLabel;           //作者
@property (nonatomic, strong) UILabel *timeLabel;           //时间
@property (nonatomic, strong) UILabel *temperatureLabel;    //回复数目

@property (nonatomic, strong) CDLabel *titleLabel;      //标题

@end

@implementation CDDiscussionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
    }
    return self;
    
}

-(void)installWithObject:(CDDiscussionModel *)object {
    self.titleLabel.text = object.title;
    
    self.nameLabel.text = object.author;
    self.timeLabel.text = object.time;
    self.temperatureLabel.text = object.comments;
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH-32, 150);
}

#pragma mark -

- (void)configSubviews {

    self.nameLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = FontDarkGray;
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 1;
        label;
    });
    
    self.timeLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = FontDarkGray;
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 1;
        label;
    });

    self.temperatureLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = FontDarkGray;
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 1;
        label;
    });
    
    self.authorIcon = ({
        UIImageView *imgView = [UIImageView new];
        imgView.image = [UIImage imageNamed:@"person_11x10_"];
        imgView;
    });
    self.timeIcon = ({
        UIImageView *imgView = [UIImageView new];
        imgView.image = [UIImage imageNamed:@"clock_11x10_"];
        imgView;
    });
    self.commentIcon = ({
        UIImageView *imgView = [UIImageView new];
        imgView.image = [UIImage imageNamed:@"chat_11x10_"];
        imgView;
    });
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.temperatureLabel];
    
    
    [self.contentView addSubview:self.authorIcon];
    [self.contentView addSubview:self.timeIcon];
    [self.contentView addSubview:self.commentIcon];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(self.titleLabel.font.lineHeight * 2 + 2);
    }];
    
    [self.commentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [self.temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentIcon.mas_right).offset(3);
        make.centerY.equalTo(self.commentIcon);
    }];
    
    [self.timeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commentIcon);
        make.left.equalTo(self.temperatureLabel.mas_right).offset(10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeIcon.mas_right).offset(3);
        make.centerY.equalTo(self.commentIcon);
    }];

    [self.authorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commentIcon);
        make.left.equalTo(self.timeLabel.mas_right).offset(10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorIcon.mas_right).offset(3);
        make.centerY.equalTo(self.commentIcon);
    }];
}

#pragma mark -

- (CDLabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[CDLabel alloc] init];
        _titleLabel.textColor = FontBlack;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.verticalAlignment = CDVerticalAlignmentTop;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

@end
