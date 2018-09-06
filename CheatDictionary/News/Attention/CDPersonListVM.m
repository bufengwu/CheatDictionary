//
//  CDPersonListVM.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/14.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDPersonListVM.h"
#import "CDPersonRecModel.h"
#import "CDPersonRecCell.h"

@implementation CDPersonListVM

- (void)loadData {
    NSString *jPath = [[NSBundle mainBundle] pathForResource:@"person_list" ofType:@"json"];
    NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jPath] options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *data = [jDic objectForKey:@"data"];
    NSArray *items = [data objectForKey:@"items"];
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *item in items) {
        CDPersonRecModel *model = [CDPersonRecModel modelWithJSON:item];
        [mutableArray addObject:model];
    }
    
    self.objects = mutableArray;
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDPersonRecCell"      : [CDPersonRecCell class],
             };
}

@end
