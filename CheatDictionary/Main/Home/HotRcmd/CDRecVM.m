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
    NSDictionary *payload = @{
                              @"idx" : @111123
                              };
    [CDApiClient GET:@"hot_rcmd" payload:payload success:^(NSDictionary *data) {
        
        NSArray *items = [data objectForKey:@"items"];
        
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
        
        if (self.completeLoadDataBlock) {
            self.completeLoadDataBlock(YES);
        }
        
    } failure:^(NSInteger code, NSString *message) {
        
        if (self.completeLoadDataBlock) {
            self.completeLoadDataBlock(NO);
        }
    }];
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
