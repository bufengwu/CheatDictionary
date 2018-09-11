//
//  CDDiscussionDetailCell.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/16.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDDiscussionDetailCell.h"
#import "CDDiscussionDetailModel.h"

@interface CDDiscussionDetailCell() <UITextViewDelegate>

@property (nonatomic, strong) UIImageView *avatarImageView; //头像
@property (nonatomic, strong) UILabel *nameLabel;           //作者
@property (nonatomic, strong) UIImageView *avatarBorderImageView;

@property (nonatomic, strong) UILabel *timeLabel;           //时间

@property (nonatomic, strong) UILabel *floorLabel;

@property (nonatomic, strong) UILabel *contentLabel;    //内容
//@property (nonatomic, strong) UITableView *replyTableView;    //评论

@property (nonatomic, strong) UITextView *commentsLabel;

@property (nonatomic, strong) UIButton *commentButton;

@end

@implementation CDDiscussionDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
    }
    return self;
    
}

-(void)installWithObject:(CDDiscussionDetailModel *)object {
    self.contentLabel.text = object.content;
    
    self.nameLabel.text = object.name;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:object.avatar] placeholderImage:[UIImage imageNamed:@"icon_avatar_default"]];
    
    self.timeLabel.text = object.time;
    
    self.floorLabel.text = [NSString stringWithFormat:@"|  %lu楼", (unsigned long)object.floor];
    
    
    if (object.leader_name) {
        self.commentsLabel.hidden = NO;
        
        NSAttributedString *fromName = [[NSAttributedString alloc] initWithString:object.leader_name attributes:@{
                                                                                                               NSFontAttributeName : [UIFont systemFontOfSize:12],
                                                                                                               NSForegroundColorAttributeName: [UIColor blueColor],
                                                                                                               NSLinkAttributeName : object.leader_uri
                                                                                                               
                                                                                                               }];
        
        NSAttributedString *linkString = [[NSAttributedString alloc] initWithString:object.comments_num > 1 ? @"等人  " : @" " attributes:@{
                                                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:12],
                                                                                                                  NSForegroundColorAttributeName: [UIColor grayColor],
                                                                                                                  }];
        NSString *tmp = [NSString stringWithFormat:@"共%lu条回复 >", (unsigned long)object.comments_num];
        NSAttributedString *comments = [[NSAttributedString alloc] initWithString:tmp attributes:@{
                                                                                                   NSFontAttributeName : [UIFont systemFontOfSize:12],
                                                                                                   NSForegroundColorAttributeName: [UIColor blueColor],
                                                                                                   NSLinkAttributeName : object.comments_uri
                                                                                                   
                                                                                                   }];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
        [string appendAttributedString:fromName];
        [string appendAttributedString:linkString];
        [string appendAttributedString:comments];
        
        self.commentsLabel.attributedText = string;
        
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_bottom).offset(5);
            make.left.equalTo(self.avatarImageView.mas_right).offset(5);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        [self.commentsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(30);
            make.right.equalTo(self.contentView).offset(-10);
            
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    } else {
        self.commentsLabel.hidden = YES;
        
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_bottom).offset(5);
            make.left.equalTo(self.avatarImageView.mas_right).offset(5);
            make.right.equalTo(self.contentView).offset(-10);
            
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
        [self.commentsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
        
    }
}

+ (CGSize)getSizeWithObject:(id)object {
    return CGSizeMake(SCREEN_WIDTH-32, 70);
}

#pragma mark -

- (void)configSubviews {
    
    self.avatarImageView = [[UIImageView alloc] init];
    _avatarImageView.layer.cornerRadius = 8;
    _avatarImageView.clipsToBounds = YES;
    
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
    
//    self.replyTableView = ({
//        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        tableView.delegate = self;
//        tableView.dataSource = self;
////        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//        tableView.scrollEnabled = NO;
//        tableView;
//    });
    
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.floorLabel];
    
    [self.contentView addSubview:self.contentLabel];
    
    [self.contentView addSubview:self.commentsLabel];
    
    [self.contentView addSubview:self.avatarBorderImageView];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(18);
        make.center.equalTo(self.avatarBorderImageView);
    }];
    
    [self.avatarBorderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.height.width.mas_equalTo(24);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarBorderImageView.mas_right).offset(5);
        make.top.equalTo(self.avatarBorderImageView);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarBorderImageView.mas_right).offset(5);
        make.bottom.equalTo(self.avatarBorderImageView);
    }];
    
    [self.floorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).offset(5);
        make.centerY.equalTo(self.timeLabel);
    }];
    
    [self.contentView addSubview:self.commentButton];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(@10);
        make.width.equalTo(@51);
        make.height.equalTo(@18);
    }];
}

- (UIImageView *)avatarBorderImageView {
    if (!_avatarBorderImageView) {
        _avatarBorderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        _avatarBorderImageView.image = [UIImage imageNamed:@"list_header_bg_34x34_"];
    }
    return _avatarBorderImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = FontBlack;
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)floorLabel {
    if (!_floorLabel) {
        _floorLabel = [UILabel new];
        _floorLabel.text = @"1#";
        _floorLabel.font = [UIFont systemFontOfSize:10];
        _floorLabel.textColor = FontDarkGray;
    }
    return _floorLabel;
}

- (UITextView *)commentsLabel {
    if (!_commentsLabel) {
        _commentsLabel = [[UITextView alloc] init];
        _commentsLabel.editable = NO;
        _commentsLabel.scrollEnabled = NO;
        _commentsLabel.backgroundColor = MainDarkBrownColor;
        
        _commentsLabel.delegate = self;
    }
    return _commentsLabel;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [[UIButton alloc] init];
        _commentButton.backgroundColor = [UIColor clearColor];
        [_commentButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [_commentButton setTitle:@"回复" forState:UIControlStateNormal];
        [_commentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_commentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        
        [_commentButton setImage:[UIImage imageNamed:@"common_comment_night_22x21_"] forState:UIControlStateNormal];
        _commentButton.imageEdgeInsets = UIEdgeInsetsMake(4, 2, 4, 36);
        _commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 0);
        
    }
    return _commentButton;
}

#pragma mark -

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    [[CDRouter shared] pushUrl:URL.absoluteString animated:YES];
    
    return YES;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 2;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 40;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//    }
//
//    NSAttributedString *name = [[NSAttributedString alloc] initWithString:@"王大锤" attributes:@{
//                                                                                              NSFontAttributeName : [UIFont systemFontOfSize:12],
//                                                                                              NSForegroundColorAttributeName: [UIColor blueColor]
//                                                                                              }];
//    NSAttributedString *toName = [[NSAttributedString alloc] initWithString:@"MTJJ" attributes:@{
//                                                                                                NSFontAttributeName : [UIFont systemFontOfSize:12],
//                                                                                                NSForegroundColorAttributeName: [UIColor blueColor]
//                                                                                                }];
//
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:name];
//    [string appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" 回复 "]];
//    [string appendAttributedString:toName];
//    [string appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" : "]];
//    [string appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"顶楼主，去年我遇到了同样的问题，困扰了许久也没有答案"]];
//
//    cell.textLabel.attributedText = string;
//    cell.textLabel.numberOfLines = 0;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = MainLightBrownColor;
//    return cell;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    return @"共10条评论";
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 25;
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
//
//    ((UITableViewHeaderFooterView *)view).contentView.backgroundColor = MainLightBrownColor;
//    ((UITableViewHeaderFooterView *)view).textLabel.font = [UIFont systemFontOfSize:12];
//
//}

@end
