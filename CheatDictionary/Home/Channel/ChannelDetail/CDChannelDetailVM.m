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
    NSString *jPath = [[NSBundle mainBundle] pathForResource:@"post_list" ofType:@"json"];
    NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jPath] options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *data = [jDic objectForKey:@"data"];
    NSDictionary *header = [data objectForKey:@"header"];
    NSArray *sticky_post = [data objectForKey:@"sticky_post"];
    NSArray *items = [data objectForKey:@"items"];
    
    NSMutableArray *mutableArray = [NSMutableArray array];

    CDBarHeaderModel *headModel = [CDBarHeaderModel modelWithJSON:header];
    [mutableArray addObject:headModel];
    
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
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    self.objects = mutableArray;
    
    {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < 15; i++) {
            CDArticleModel *model = [CDArticleModel new];
            model.icon = @"";
            model.title = @"iOS6的系统API结合autolayout";
            model.desc = @"控件的约束和第一个方法的一样，下面列出的代码是和第一个方法不同的地方。该方法的demo和第一个方法的demo是同一个，每个方法独立使用到的代码我会特别注明，没有注明就是所有方法共有的";
            model.icon = @"article_image_default";
            
            model.uri = @"CDArticleDetailVC";
            [mutableArray addObject:model];
        }
        
        self.articles = mutableArray;
    }
    
    if (self.completeLoadDataBlock) {
        self.completeLoadDataBlock();
    }
    //    });
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
