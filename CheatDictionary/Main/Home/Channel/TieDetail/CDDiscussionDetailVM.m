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
    NSString *jPath = [[NSBundle mainBundle] pathForResource:@"discussion_detail_00932" ofType:@"json"];
    NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jPath] options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *data = [jDic objectForKey:@"data"];
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
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    self.objects = mutableArray;
    
    //    });
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDDiscussionDetailUpperCell" : [CDDiscussionDetailUpperCell class],
             @"CDDiscussionDetailCell"      : [CDDiscussionDetailCell class],
             };
}

@end
