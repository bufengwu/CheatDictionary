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
    [CDApiClient GET:@"article_detail" success:^(NSDictionary *data) {
        NSArray *comments = [data objectForKey:@"comments"];
        NSArray *article = [data objectForKey:@"article"];
        
        self.atricleSourceArray = article;
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSDictionary *comment in comments) {
            CDDiscussionDetailModel *model = [CDDiscussionDetailModel modelWithJSON:comment];
            [mutableArray addObject:model];
        }
        
        self.commentArray = mutableArray;
        
        if (self.completeLoadDataBlock) {
            self.completeLoadDataBlock(YES);
        }
        
    } failure:^(NSInteger code, NSString *message) {
        
        if (self.completeLoadDataBlock) {
            self.completeLoadDataBlock(NO);
        }
    }];
}

@end
