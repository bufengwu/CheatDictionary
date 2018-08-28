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
    
    CDSectionModel *section = [CDSectionModel new];
    {
        CDShowMoreHeaderModel *header = [CDShowMoreHeaderModel new];
        header.title = @"关注";
        header.more = @"全部";
        header.uri = @"CDPersonListVC";
        section.headerModel = header;
        section.objects = [NSMutableArray array];
        
        CDCovergeItemModel *coverItem = [CDCovergeItemModel new];
        [section.objects addObject:coverItem];
    }
    
    CDSectionModel *section2 = [CDSectionModel new];
    {
        CDShowMoreHeaderModel *header = [CDShowMoreHeaderModel new];
        header.title = @"动态";
        section2.headerModel = header;
        
        section2.objects = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            CDMomentModel *model = [CDMomentModel new];
            model.avatarImage = @"icon_avatar_default";
            model.name = @"窃 格瓦拉";
            model.time = @"7月5日";
            model.action = @"发表文章";
            model.uri = @"CDArticleDetailVC";
            model.momentTitle = @"打工这方面......打工是不可能打工的 这辈子不可能打工的，做生意又不会做，就是偷这种东西，才能维持得了生活这样子.";
            [section2.objects addObject:model];
        }
    }
    
    self.objects = @[section, section2];
}

- (NSDictionary<NSString *,Class> *)cellIdentifierMapping {
    return @{
             @"CDCovergeItemCell" : [CDCovergeItemCell class],
             @"CDMomentCell" :[CDMomentCell class]
             };
}

@end
