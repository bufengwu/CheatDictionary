//
//  CDArticleListVM.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/3.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDArticleListVM.h"
#import "CDArticleCoverCell.h"

@implementation CDArticleListVM

- (void)loadData {
    
    NSMutableArray *mutableArray = [NSMutableArray array];
 
    for (int i = 0; i < 6; i++) {
        CDArticleCoverModel *roomModel = [CDArticleCoverModel new];
        roomModel.icon = @"";
        roomModel.title = @"诗经中的植物";
//        roomModel.number = 330;
        [mutableArray addObject:roomModel];
    }
    self.objects = mutableArray;
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDArticleCoverCell"      : [CDArticleCoverCell class],
             };
}

@end
