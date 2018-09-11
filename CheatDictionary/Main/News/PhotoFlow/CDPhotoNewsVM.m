//
//  CDPhotoNewsVM.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/21.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDPhotoNewsVM.h"
#import "CDPhotoFlowNewsModel.h"
#import "CDSectionModel.h"

@implementation CDPhotoNewsVM

- (void)loadData {
    
    NSString *jPath = [[NSBundle mainBundle] pathForResource:@"photo_flow" ofType:@"json"];
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
            CDPhotoFlowNewsModel *channelModel = [CDPhotoFlowNewsModel modelWithJSON:channel];
            [sectionModel.objects addObject:channelModel];
        }
        [mutableArray addObject:sectionModel];
    }
    
    self.objects = mutableArray;
}

@end
