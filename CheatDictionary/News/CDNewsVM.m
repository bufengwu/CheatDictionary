//
//  CDNewsVM.m
//  CheatDictionary
//
//  Created by 朱正毅 on 2018/7/27.
//  Copyright © 2018年 朱正毅. All rights reserved.
//

#import "CDNewsVM.h"
#import "CDArticleCell.h"
#import "CDArticleModel.h"

@implementation CDNewsVM

- (void)loadData {
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < 15; i++) {
        CDArticleModel *model = [CDArticleModel new];
        model.title = @"iOS6的系统API结合autolayout";
        model.desc = @"控件的约束和第一个方法的一样，下面列出的代码是和第一个方法不同的地方。该方法的demo和第一个方法的demo是同一个，每个方法独立使用到的代码我会特别注明，没有注明就是所有方法共有的";
        model.cover = @"article_image_default";
        
        model.uri = @"CDArticleDetailVC";
        [mutableArray addObject:model];
    }
    
    self.objects = mutableArray;
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDArticleCell"     : [CDArticleCell class],
             };
}

@end
