//
//  CDAttentionVM.m
//  CheatDictionary
//
//  Created by zzy on 2018/7/13.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDAttentionVM.h"

#import "CDSectionModel.h"
#import "CDCovergeItemCell.h"
#import "CDCovergeItemModel.h"

#import "CDMomentCell.h"
#import "CDMomentModel.h"
#import "CDShowMoreHeaderModel.h"

@implementation CDAttentionVM

- (void)loadData {
    
    NSString *jPath = [[NSBundle mainBundle] pathForResource:@"attention" ofType:@"json"];
    NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jPath] options:NSJSONReadingMutableLeaves error:nil];
    NSArray *items = [[jDic objectForKey:@"data"] objectForKey:@"items"];
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (NSDictionary *item in items) {
        CDSectionModel *sectionModel = [CDSectionModel new];
        CDShowMoreHeaderModel *header = [CDShowMoreHeaderModel new];
        header.title = item[@"title"];
        header.more = item[@"more"];
        header.uri = item[@"uri"];
        sectionModel.headerModel = header;
        sectionModel.objects = [NSMutableArray array];
        NSArray *items = item[@"items"];
        for (NSDictionary *item in items) {
            
            NSString *cardType = item[@"card_type"];
            if ([cardType isEqualToString:@"coverage"]) {
                CDCovergeItemModel *model = [CDCovergeItemModel modelWithJSON:item];
                [sectionModel.objects addObject:model];
                
            } else if ([cardType isEqualToString:@"moment"]) {
                CDMomentModel *model = [CDMomentModel modelWithJSON:item];
                [sectionModel.objects addObject:model];
            }
            
        }
        [mutableArray addObject:sectionModel];
    }   
    
    self.objects = mutableArray;
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDCovergeItemCell" : [CDCovergeItemCell class],
             @"CDMomentCell" :[CDMomentCell class]
             };
}

@end
