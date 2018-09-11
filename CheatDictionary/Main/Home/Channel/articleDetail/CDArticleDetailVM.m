//
//  CDArticleDetailVM.m
//  CheatDictionary
//
//  Created by zzy on 2018/9/6.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDArticleDetailVM.h"

@implementation CDArticleDetailVM

- (void)loadData {
    NSString *jPath = [[NSBundle mainBundle] pathForResource:@"article_detail" ofType:@"json"];
    NSDictionary *jDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jPath] options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *data = [jDic objectForKey:@"data"];
    NSArray *comments = [data objectForKey:@"comments"];
    NSArray *article = [data objectForKey:@"article"];
    
    self.atricleSourceArray = article;
    
    NSMutableArray *mutableArray = [NSMutableArray array];    
    for (NSDictionary *comment in comments) {
        CDDiscussionDetailModel *model = [CDDiscussionDetailModel modelWithJSON:comment];
        [mutableArray addObject:model];
    }
    
    self.commentArray = mutableArray;
}

@end
