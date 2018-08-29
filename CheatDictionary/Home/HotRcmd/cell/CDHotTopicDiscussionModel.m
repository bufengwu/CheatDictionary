//
//  CDHotTopicDisscusionModel.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/8/7.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDHotTopicDiscussionModel.h"
#import "CDHotTopicDiscussionCell.h"

@implementation CDHotTopicDiscussionReplyModel

@end

@implementation CDHotTopicDiscussionModel

- (Class)cellClass {
    return [CDHotTopicDiscussionCell class];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"replys" : [CDHotTopicDiscussionReplyModel class],
             };
}

@end
