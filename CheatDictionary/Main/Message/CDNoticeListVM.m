//
//  CDNoticeListVM.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/14.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDNoticeListVM.h"
#import "CDNoticeCell.h"
#import "CDNoticeModel.h"

@implementation CDNoticeListVM

- (void)loadData {

    [CDApiClient GET:@"message" success:^(NSDictionary *data) {
        NSArray *items = [data objectForKey:@"items"];
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSDictionary *item in items) {
            CDNoticeModel *model = [CDNoticeModel modelWithJSON:item];
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
             @"CDNoticeCell" : [CDNoticeCell class],
             };
}

@end
