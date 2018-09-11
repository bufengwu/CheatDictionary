//
//  CDDiscussionDetailVM.m
//  CheatDictionary
//
//  Created by zzy on 2018/8/10.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDDiscussionDetailVM.h"

#import "CDDiscussionDetailUpperModel.h"
#import "CDDiscussionDetailUpperCell.h"
#import "CDDiscussionDetailModel.h"
#import "CDDiscussionDetailCell.h"

@implementation CDDiscussionDetailVM
- (void)loadData {
    [CDApiClient GET:@"topic_detail" success:^(NSDictionary *data) {
        
        NSDictionary *asker = [data objectForKey:@"asker"];
        NSArray *answers = [data objectForKey:@"answers"];
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        {
            CDDiscussionDetailUpperModel *model = [CDDiscussionDetailUpperModel modelWithJSON:asker];
            [mutableArray addObject:model];
        }
        
        for (NSDictionary *answer in answers) {
            CDDiscussionDetailModel *model = [CDDiscussionDetailModel modelWithJSON:answer];
            [mutableArray addObject:model];
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
             @"CDDiscussionDetailUpperCell" : [CDDiscussionDetailUpperCell class],
             @"CDDiscussionDetailCell"      : [CDDiscussionDetailCell class],
             };
}

@end
