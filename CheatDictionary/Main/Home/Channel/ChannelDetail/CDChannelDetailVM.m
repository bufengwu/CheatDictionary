//
//  CDChannelDetailVM.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/9.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDChannelDetailVM.h"

#import "CDSectionModel.h"
#import "CDBarHeaderModel.h"
#import "CDStickyPostModel.h"
#import "CDDiscussionModel.h"

#import "CDBarHeaderCell.h"
#import "CDStickyPostCell.h"
#import "CDDiscussionCell.h"

#import "CDArticleCell.h"
#import "CDArticleModel.h"

@implementation CDChannelDetailVM

- (void)loadData {
    
    [CDApiClient GET:@"channel_detail" success:^(NSDictionary *data) {
        
        NSDictionary *header = [data objectForKey:@"header"];
        NSArray *sticky_post = [data objectForKey:@"sticky_post"];
        NSArray *items = [data objectForKey:@"items"];
        NSArray *articles = [data objectForKey:@"articles"];
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        {
            CDSectionModel *sectionModel = [CDSectionModel new];
            sectionModel.objects = [NSMutableArray array];
            CDBarHeaderModel *headModel = [CDBarHeaderModel modelWithJSON:header];
            [sectionModel.objects addObject:headModel];
            
            [mutableArray addObject:sectionModel];
        }
        
        {
            CDSectionModel *sectionModel = [CDSectionModel new];
            sectionModel.objects = [NSMutableArray array];
            for (NSDictionary *item in sticky_post) {
                CDStickyPostModel *stickyModel = [CDStickyPostModel modelWithJSON:item];
                [sectionModel.objects addObject:stickyModel];
            }
            
            [mutableArray addObject:sectionModel];
        }
        
        {
            CDSectionModel *sectionModel = [CDSectionModel new];
            
            CDShowMoreHeaderModel *headerModel = [CDShowMoreHeaderModel new];
            headerModel.title = @"帖子";
            sectionModel.headerModel = headerModel;
            
            sectionModel.objects = [NSMutableArray array];
            for (NSDictionary *item in items) {
                CDDiscussionModel *channelModel = [CDDiscussionModel modelWithJSON:item];
                [sectionModel.objects addObject:channelModel];
            }
            [mutableArray addObject:sectionModel];
        }
        
        self.objects = mutableArray;
        
        {
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (NSDictionary *article in articles) {
                CDArticleModel *model = [CDArticleModel modelWithJSON:article];
                [mutableArray addObject:model];
            }
            self.articles = mutableArray;
        }
        
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
             @"CDBarHeaderCell"   : [CDBarHeaderCell class],
             @"CDStickyPostCell"  : [CDStickyPostCell class],
             @"CDDiscussionCell"  : [CDDiscussionCell class],
             @"CDArticleCell"     : [CDArticleCell class],
             };
}

@end
