//
//  CDHotTopicDiscussionCell.h
//  CheatDictionary
//
//  Created by zzy on 2018/8/7.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseTableViewCell.h"
#import "CDCustomTagLabel.h"

/**
 首页 热门列表中的热帖cell
 */
@interface CDHotTopicDiscussionCell : CDBaseTableViewCell

@property (nonatomic, strong) UILabel *rankLabel;   //热度名次 仅前三名
@property (nonatomic, strong) UILabel *authorLabel; //楼主

@property (nonatomic, strong) UILabel *titleLabel;  //标题 必备     //最多三行

//下面这几项是可选的
@property (nonatomic, strong) UIImageView *coverImageView;  //贴近话题的图片，或者帖子中出现的热图        //如果有图了，则不会显示评论

@property (nonatomic, strong) UILabel *contentLabel;    //因楼主话题而火，显示1楼内容    //最多两行

@property (nonatomic, strong) UILabel *replyLabel1; //因某条评论而火，显示评论      //一定不会带图
@property (nonatomic, strong) UILabel *replyLabel2;
@property (nonatomic, strong) UILabel *replyLabel3;

@end
