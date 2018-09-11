//
//  CDNoticeModel.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDNoticeModel.h"
#import "CDNoticeCell.h"

@implementation CDNoticeModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithDictionary:[super modelCustomPropertyMapper]];
    NSDictionary *dict = @{
                           @"avatarImage"   : @"avatar",
                           @"name"          : @"name",
                           @"time"          : @"time",
                           @"action"        : @"action",
                           @"noticeTitle"   : @"content",
                           @"myMomentTitle" : @"from",
                           };
    [tempDict addEntriesFromDictionary:dict];
    return [NSDictionary dictionaryWithDictionary:tempDict];
}

- (Class)cellClass {
    return [CDNoticeCell class];
}

@end
