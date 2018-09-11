//
//  CDChannelVM.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/12.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDChannelVM.h"

#import "CDSectionModel.h"

#import "CDShowMoreHeaderModel.h"
#import "CDSectionHeaderShowMoreView.h"

#import "CDChannelCoverModel.h"
#import "CDChannelCoverCell.h"

@implementation CDChannelVM

- (void)loadData {
    
    [CDApiClient GET:@"channel" success:^(NSDictionary *data) {
        
        NSArray *items = [data objectForKey:@"items"];
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (NSDictionary *item in items) {
            CDSectionModel *sectionModel = [CDSectionModel new];
            CDShowMoreHeaderModel *header = [CDShowMoreHeaderModel new];
            header.title = item[@"title"];
            sectionModel.headerModel = header;
            sectionModel.objects = [NSMutableArray array];
            NSArray *channels = item[@"items"];
            for (NSDictionary *channel in channels) {
                
                CDChannelCoverModel *channelModel = [CDChannelCoverModel modelWithJSON:channel];
                [sectionModel.objects addObject:channelModel];
            }
            [mutableArray addObject:sectionModel];
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
             @"CDChannelCoverCell"     : [CDChannelCoverCell class],
             };
}

- (NSDictionary<NSString *,Class> *)headerIdentifierMapping {
    return @{
             @"CDSectionHeaderShowMoreView" : [CDSectionHeaderShowMoreView class],
             };
}

@end
