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
    
    [CDApiClient GET:@"attention" success:^(NSDictionary *data) {
        
        NSArray *items = [data objectForKey:@"items"];
        
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
                NSString *card_type = item[@"card_type"];
                
                Class cls = [CDCardPool modelFoyCardType:card_type];
                
                CDBaseCellModel *model = [cls modelWithJSON:item];
                [sectionModel.objects addObject:model];
                
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
             @"CDCovergeItemCell" : [CDCovergeItemCell class],
             @"CDMomentCell" :[CDMomentCell class]
             };
}

@end
