//
//  CDRevVM.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDRecVM.h"
#import "CDArticleCell.h"
#import "CDArticleModel.h"

#import "CDTopActivityCell.h"
#import "CDTopActivityModel.h"

#import "CDSectionModel.h"

#import "CDFeedBannerCell.h"
#import "CDFeedBannerModel.h"

#import "CDHotTopicDiscussionCell.h"
#import "CDHotTopicDiscussionModel.h"

@implementation CDRecVM

- (void)loadData {
    
    NSString *jPath = [[NSBundle mainBundle] pathForResource:@"hottopic" ofType:@"json"];
    NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jPath] options:NSJSONReadingMutableLeaves error:nil];
    NSArray *items = [[jDic objectForKey:@"data"] objectForKey:@"items"];
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (NSDictionary *item in items) {
        NSString *card_type = item[@"card_type"];
        
        if ([card_type isEqualToString:@"feed_banner"]) {
            CDFeedBannerModel *feed = [CDFeedBannerModel modelWithJSON:item];
            [mutableArray addObject:feed];
        } else if ([card_type isEqualToString:@"challenge"]) {
            CDTopActivityModel *topActivityModel = [CDTopActivityModel modelWithJSON:item];
            [mutableArray addObject:topActivityModel];
        } else if ([card_type isEqualToString:@"feed_post"]) {
            CDHotTopicDiscussionModel *model = [CDHotTopicDiscussionModel modelWithJSON:item];
            [mutableArray addObject:model];
        }        
    }
    
    self.objects = mutableArray;
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDArticleCell"     : [CDArticleCell class],
             @"CDTopActivityCell"   :[CDTopActivityCell class],
             @"CDFeedBannerCell":[CDFeedBannerCell class],
             @"CDHotTopicDiscussionCell" : [CDHotTopicDiscussionCell class]
             };
}

@end
