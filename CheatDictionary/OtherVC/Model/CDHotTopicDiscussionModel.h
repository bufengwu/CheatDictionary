//
//  CDHotTopicDisscusionModel.h
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/8/7.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDBaseCellModel.h"

@interface CDHotTopicDiscussionReplyModel : NSObject

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *content;

@end

@interface CDHotTopicDiscussionModel : CDBaseCellModel

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, assign) NSUInteger rank;
@property (nonatomic, strong) NSString *title;


//可选
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray<CDHotTopicDiscussionReplyModel *> *replys;

@end
