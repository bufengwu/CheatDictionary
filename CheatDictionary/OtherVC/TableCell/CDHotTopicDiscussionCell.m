//
//  CDHotTopicDiscussionCell.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/7.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDHotTopicDiscussionCell.h"
#import "CDHotTopicDiscussionModel.h"

@interface CDHotTopicDiscussionCell()

@property (nonatomic, strong) UIView *replyContainer;

@end

@implementation CDHotTopicDiscussionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)installWithObject:(CDHotTopicDiscussionModel *)object {

    self.rankLabel.hidden = YES;
    self.coverImageView.hidden = YES;
    self.contentLabel.hidden = YES;
    self.replyContainer.hidden = YES;
    
    self.rankLabel.text = [NSString stringWithFormat:@"%02lu", (unsigned long)object.rank];
    self.authorLabel.text = object.author;
    
    if (object.rank > 0) {
        self.rankLabel.hidden = NO;
        [self.rankLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(10);
            make.width.equalTo(@22);
            make.height.equalTo(@13.5);
        }];
        [self.authorLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rankLabel);
            make.left.equalTo(self.rankLabel.mas_right).offset(10);
        }];
    } else {
        [self.authorLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(10);
        }];
    }
    
    self.titleLabel.text = object.title;
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        
        make.right.equalTo( object.cover ? self.coverImageView.mas_left :  self.contentView.mas_right).offset(-10);
        
        if (object.content) {
            make.bottom.equalTo(self.contentLabel.mas_top).offset(-5);
        } else if (object.replys.count > 0) {
            make.bottom.equalTo(self.replyContainer.mas_top).offset(-5);
        } else {
            make.bottom.equalTo(self.contentView).offset(-10);
            make.bottom.greaterThanOrEqualTo(self.coverImageView);
        }
    }];
    
    
    if ([object.content length]) {
        self.contentLabel.hidden = NO;
        self.contentLabel.text = object.content;
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            
            make.right.equalTo( object.cover ? self.coverImageView.mas_left :  self.contentView.mas_right).offset(-10);
            
            if (object.replys.count > 0) {
                make.bottom.equalTo(self.replyContainer.mas_top).offset(-5);
            } else {
                make.bottom.equalTo(self.contentView).offset(-10);
                make.bottom.greaterThanOrEqualTo(self.coverImageView);
            }
        }];
    }
    
    if ([object.cover length]) {
        self.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:object.cover] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        self.coverImageView.hidden = NO;
        [self.coverImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorLabel.mas_bottom);
            make.right.equalTo(self.contentView).offset(-10);
            make.width.mas_equalTo(95);
            make.height.mas_equalTo(60);
        }];
    }

    if (object.replys.count > 0) {
        self.replyContainer.hidden = NO;
        switch (object.replys.count) {
            case 3:            
                self.replyLabel3.attributedText = [self replyString:object.replys[2]];
            case 2:
                self.replyLabel2.attributedText = [self replyString:object.replys[1]];
            case 1:
                self.replyLabel1.attributedText = [self replyString:object.replys[0]];
                break;
            default:
                break;
        }
        [self.replyContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.left.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
}

- (NSAttributedString *)replyString:(CDHotTopicDiscussionReplyModel *)model {
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:[model.author stringByAppendingString:@": "] attributes:@{
                                                                                                                                      NSFontAttributeName : [UIFont systemFontOfSize:12],
                                                                                                                                      NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                                                                                                                      }];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:model.content attributes:@{
                                                                                               NSFontAttributeName : [UIFont systemFontOfSize:12],
                                                                                               NSForegroundColorAttributeName: [UIColor grayColor]
                                                                                               
                                                                                               }];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    [string appendAttributedString:str1];
    [string appendAttributedString:str2];
    return string;
}

#pragma mark -

- (void)configSubviews {
    [self.contentView addSubview:self.rankLabel];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.contentLabel];
    
    [self.contentView addSubview:self.replyContainer];
    [self.replyContainer addSubview:self.replyLabel1];
    [self.replyContainer addSubview:self.replyLabel2];
    [self.replyContainer addSubview:self.replyLabel3];
    
    [self.replyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.replyContainer).offset(-10);
        make.left.equalTo(self.replyContainer).offset(10);
        make.top.equalTo(self.replyContainer).offset(10);
    }];

    [self.replyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.replyContainer).offset(-10);
        make.left.equalTo(self.replyContainer).offset(10);
        make.top.equalTo(self.replyLabel1.mas_bottom);
    }];

    [self.replyLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.replyContainer).offset(-10);
        make.left.equalTo(self.replyContainer).offset(10);
        make.top.equalTo(self.replyLabel2.mas_bottom);
        make.bottom.equalTo(self.replyContainer).offset(-10);
    }];
    
}

- (UILabel *)rankLabel {
    if (!_rankLabel) {
        _rankLabel = [[UILabel alloc] init];
        _rankLabel.font = [UIFont systemFontOfSize:11];
        _rankLabel.textAlignment = NSTextAlignmentCenter;
        _rankLabel.layer.cornerRadius = 2;
        _rankLabel.backgroundColor = RGB(205, 183, 158);
    }
    return _rankLabel;
}

-(UILabel *)authorLabel {
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = [UIFont systemFontOfSize:12];
    }
    return _authorLabel;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [UIImageView new];
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = FontBlack;
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = FontBlack;
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.numberOfLines = 3;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}


- (UIView *)replyContainer {
    if (!_replyContainer) {
        _replyContainer = [UIView new];
        _replyContainer.backgroundColor = CollectCellBG;
    }
    return _replyContainer;
}

- (UILabel *)replyLabel1 {
    if (!_replyLabel1) {
        _replyLabel1 = [UILabel new];
        _replyLabel1.textColor = FontBlack;
        _replyLabel1.font = [UIFont systemFontOfSize:12];
    }
    return _replyLabel1;
}

- (UILabel *)replyLabel2 {
    if (!_replyLabel2) {
        _replyLabel2 = [UILabel new];
        _replyLabel2.textColor = FontBlack;
        _replyLabel2.font = [UIFont systemFontOfSize:12];
    }
    return _replyLabel2;
}

- (UILabel *)replyLabel3 {
    if (!_replyLabel3) {
        _replyLabel3 = [UILabel new];
        _replyLabel3.textColor = FontBlack;
        _replyLabel3.font = [UIFont systemFontOfSize:12];
    }
    return _replyLabel3;
}



@end
