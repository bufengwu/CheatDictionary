//
//  CDCardPool.m
//  CheatDictionary
//
//  Created by zzy on 2018/9/11.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDCardPool.h"

#import "CDTopActivityModel.h"
#import "CDFeedBannerModel.h"
#import "CDHotTopicDiscussionModel.h"

#import "CDCovergeItemModel.h"
#import "CDMomentModel.h"

@implementation CDCardPool

static NSDictionary *cellPoolDict;
static NSDictionary *modelPoolDict;

+ (NSDictionary *)allCellClassDict
{
    if (!cellPoolDict) {
        cellPoolDict = @{
                         };
    }
    return cellPoolDict;
}

+ (NSDictionary *)allModelClassDict
{
    if (!modelPoolDict) {
        modelPoolDict = @{
                          @"feed_banner": [CDFeedBannerModel class],
                          @"challenge": [CDTopActivityModel class],
                          @"feed_post": [CDHotTopicDiscussionModel class],
                          
                          @"coverage": [CDCovergeItemModel class],
                          @"moment": [CDMomentModel class],
                          };
    }
    return modelPoolDict;
}

+ (Class)cellForCardType:(NSString *)cardType {
    return [[self allCellClassDict] objectForKey:cardType];
}

+ (Class)modelFoyCardType:(NSString *)cardType {
    return [[self allModelClassDict] objectForKey:cardType];
}

@end
