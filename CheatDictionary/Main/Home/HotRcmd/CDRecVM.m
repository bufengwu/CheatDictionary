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
        [self _parseData:data];
        if (self.completeLoadDataBlock) {
            self.completeLoadDataBlock(YES);
        }
        
    } failure:^(NSInteger code, NSString *message) {
        if (!self.objects.count) {
            NSString *jPath = [[NSBundle mainBundle] pathForResource:@"hot_rcmd" ofType:@"json"];
            NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jPath] options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *data = [jDic objectForKey:@"data"];
            
            [self _parseData:data];
            if (self.completeLoadDataBlock) {
                self.completeLoadDataBlock(YES);
            }
            return;
        }
        
        if (self.completeLoadDataBlock) {
            self.completeLoadDataBlock(NO);
        }
    }];
}

- (void)_parseData:(NSDictionary *)data {
    NSArray *items = [data objectForKey:@"items"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *item in items) {
        NSString *card_type = item[@"card_type"];
        Class cls = [CDCardPool modelFoyCardType:card_type];
        CDBaseCellModel *model = [cls modelWithJSON:item];
        [mutableArray addObject:model];
    }
    self.objects = mutableArray;
    
    self.topModel = [FNHotTopicHeaderModel modelWithJSON:[data objectForKey:@"top"]];
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
