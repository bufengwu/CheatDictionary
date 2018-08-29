//
//  CDChannelVM.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/12.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDChannelVM.h"
#import "CDChannelCoverModel.h"
#import "CDSectionModel.h"
#import "CDShowMoreHeaderModel.h"
#import "CDArticleCoverModel.h"
#import "CDPersonRecModel.h"



#import "CDSectionHeaderShowMoreView.h"

#import "CDBigImageCell.h"
#import "CDChannelCoverCell.h"
#import "CDArticleCoverCell.h"
#import "CDPersonRecCell.h"


@implementation CDChannelVM

- (void)loadData {
    
    
    NSString *jPath = [[NSBundle mainBundle] pathForResource:@"channel" ofType:@"json"];
    NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jPath] options:NSJSONReadingMutableLeaves error:nil];
    NSArray *items = [[jDic objectForKey:@"data"] objectForKey:@"items"];
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (NSDictionary *item in items) {
        CDSectionModel *sectionModel = [CDSectionModel new];
        CDShowMoreHeaderModel *header = [CDShowMoreHeaderModel new];
        header.title = item[@"title"];
        sectionModel.headerModel = header;
        sectionModel.objects = [NSMutableArray array];
        NSArray *channels = item[@"items"];
        for (NSDictionary *channel in channels) {
            CDChannelCoverModel *channelModel = [CDChannelCoverModel new];
            channelModel.icon = channel[@"icon"];
            channelModel.title = channel[@"title"];
            channelModel.subtitle = channel[@"subtitle"];
            channelModel.badge = [channel[@"badge"] intValue];
            channelModel.uri = channel[@"uri"];
            [sectionModel.objects addObject:channelModel];
        }
        [mutableArray addObject:sectionModel];
    }
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.objects = mutableArray;
        
        if (self.completeLoadDataBlock) {
            self.completeLoadDataBlock();
        }
//    });
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDChannelCoverCell"     : [CDChannelCoverCell class],
             @"CDArticleCoverCell"      : [CDArticleCoverCell class],
             @"CDPersonRecCell" : [CDPersonRecCell class]
             };
}

- (NSDictionary<NSString *,Class> *)headerIdentifierMapping {
    return @{
             @"CDSectionHeaderShowMoreView" : [CDSectionHeaderShowMoreView class],
             };
}

@end
