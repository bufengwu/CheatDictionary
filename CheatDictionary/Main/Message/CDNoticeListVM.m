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
    NSString *jPath = [[NSBundle mainBundle] pathForResource:@"notice" ofType:@"json"];
    NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jPath] options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *data = [jDic objectForKey:@"data"];
    NSArray *items = [data objectForKey:@"items"];
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *item in items) {
        CDNoticeModel *model = [CDNoticeModel modelWithJSON:item];
        [mutableArray addObject:model];
    }
    
    self.objects = mutableArray;
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDNoticeCell" : [CDNoticeCell class],
             };
}

@end
